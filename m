Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTILWOm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 18:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbTILWOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 18:14:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:9878 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262018AbTILWOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 18:14:41 -0400
Date: Fri, 12 Sep 2003 15:11:55 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Daniel Blueman <daniel.blueman@gmx.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [linux-2.4.0-test5] swsusp w/o swap fail...
In-Reply-To: <5245.1063318170@www44.gmx.net>
Message-ID: <Pine.LNX.4.33.0309121509120.984-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Sep 2003, Daniel Blueman wrote:

> Clearly, software suspend needs a dependency on swapfiles being enabled.

Clearly, since it's expressed that way in the Kconfig file: 

config SOFTWARE_SUSPEND
        bool "Software Suspend (EXPERIMENTAL)"
        depends on EXPERIMENTAL && PM && SWAP


Did you hand edit the .config file, or were you able to enable 
SOFTWARE_SUSPEND w/o CONFIG_SWAP in one of the configurators? 

Thanks,


	Pat

