Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbUEJXUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUEJXUh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUEJXTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:19:32 -0400
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:49075 "EHLO
	imf20aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261746AbUEJXMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:12:55 -0400
Date: Mon, 10 May 2004 19:12:10 -0400 (EDT)
From: Richard A Nelson <cowboy@debian.org>
To: Stephen Hemminger <shemminger@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1 Oops with dummy network device (sysfs related?)
In-Reply-To: <20040510141829.467a2bb6@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0405101909450.31018@onpx40.onqynaqf.bet>
References: <Pine.LNX.4.58.0405101654130.5731@erartnqr.onqynaqf.bet>
 <20040510141829.467a2bb6@dell_ss3.pdx.osdl.net>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, Stephen Hemminger wrote:

> It would be easier to know what is wrong, if you said what you
> did that started the problem.  Looks like ifrename or something
> like that.

hrm, been trying to track that down (several oopses later...)

the modprobe dummy worked ok (and is seen in the log)
the next command is 'ip link set name ipsec0 dev dummy0'
and I've yet to get passed that

-- 
Rick Nelson
People disagree with me.  I just ignore them.
	-- Linus Torvalds, regarding the use of C++ for the Linux kernel
