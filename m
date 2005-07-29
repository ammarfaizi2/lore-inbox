Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVG2XN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVG2XN5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 19:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVG2XL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 19:11:29 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:49588 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262879AbVG2XJE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 19:09:04 -0400
Date: Sat, 30 Jul 2005 01:06:30 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Erior <lars.vahlenberg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sis190 driver
Message-ID: <20050729230630.GB10300@electric-eye.fr.zoreil.com>
References: <095433EB6AB9634BB9524203BF7E303C99AA06@EXGBGMB02.europe.cellnetwork.com> <cb755df905072914244ebbe55b@mail.gmail.com> <cb755df905072914452912d82b@mail.gmail.com> <cb755df905072915085552895b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb755df905072915085552895b@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erior <lars.vahlenberg@gmail.com> :
[...]
> Is there any kind of test or information I can provid to help you fixing
> this ?

It could help to know if the device reports a link event interrupt or such.
(ethtool allow to modify the log level of the driver if required). Don't
hesitate to publish a complete dmesg somewhere.

A generous amount of mii/phy related code remains to be merged from SiS
driver and the 8201 is labelled as requiring extra quirks in sis900.c.
It is not hopeless :o)

--
Ueimor
