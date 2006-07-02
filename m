Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWGBPLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWGBPLd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 11:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWGBPLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 11:11:33 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:52000 "EHLO
	asav05.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S932267AbWGBPLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 11:11:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAAN9p0SBSg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Congjun Yang <congjuny@yahoo.com>
Subject: Re: keyboard raw mode
Date: Sun, 2 Jul 2006 11:11:29 -0400
User-Agent: KMail/1.9.3
Cc: jbglaw@lug-owl.de, linux-kernel@vger.kernel.org
References: <20060702082133.23309.qmail@web32013.mail.mud.yahoo.com>
In-Reply-To: <20060702082133.23309.qmail@web32013.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607021111.30386.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 July 2006 04:21, Congjun Yang wrote:
> 2.6.9-22.EL(CentOS 4.2) is what I currently use.
> 2.4.20 was where I first saw, in keyboard.c, the
> workaround that throws away a second break code.
> 

I think it should work in 2.6.9... The change was put in in summer
of 2004, 2.6.9 was released in fall...

Try booting with atkbd.softraw=0 to turn off software rawmode
emulation and I think you will see all the codes from your
device.

> I think I like the new design for the user input
> system: separate the protocol layer from the raw port.
> But, would it be nice for the atkbd driver to still
> provide a raw (or passthrough) mode?
> 

It does ;)

-- 
Dmitry
