Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbTEVQAi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 12:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTEVQAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 12:00:38 -0400
Received: from [208.186.192.194] ([208.186.192.194]:181 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262590AbTEVQAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 12:00:37 -0400
Date: Thu, 22 May 2003 09:14:26 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Manuel Estrada Sainz <ranty@debian.org>
cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <jt@hpl.hp.com>,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Re: request_firmware() hotplug interface, third round
 and a halve
In-Reply-To: <20030522153154.GD13224@ranty.ddts.net>
Message-ID: <Pine.LNX.4.44.0305220911290.5889-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't have any problems with the interface, and am ok with the driver 
core and sysfs changes. I have the sysfs binary file patch, but would you 
mind sending me the class device release() patch separately? 

Also, what about just creating a drivers/firmware/ directory (or 
drivers/base/firmware/) for the core code? 

Thanks,


	-pat

