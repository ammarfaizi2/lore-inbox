Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbUBZNYS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 08:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbUBZNYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 08:24:17 -0500
Received: from mail504.nifty.com ([202.248.37.212]:27899 "EHLO
	mail504.nifty.com") by vger.kernel.org with ESMTP id S262789AbUBZNYP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 08:24:15 -0500
To: modus@pr.es.to
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to emulate 'chroot /jail/ su httpd -c' ?
From: Tetsuo Handa <a5497108@anet.ne.jp>
References: <200402261956.BEF40183.2B918856@anet.ne.jp>
	<20040226045855.A2529@pr.es.to>
In-Reply-To: <20040226045855.A2529@pr.es.to>
Message-Id: <200402262223.GGG49297.6812B985@anet.ne.jp>
X-Mailer: Winbiff [Version 2.43 (on Trial)]
X-Accept-Language: ja,en
Date: Thu, 26 Feb 2004 22:23:54 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Michael Kane <modus@pr.es.to> wrote:
> Here's an easy way to do what you are trying to do:
> 
> http://worldserver3.oleane.com/bouynot/gabuzomeu/alex/doc/apache/index-en.html
> 
> Greetings from Hiro-o!
> 
> * Tetsuo Handa (a5497108@anet.ne.jp) [040226 03:01]:
> > Hello,
> > 
> > I have the following line in /etc/rc.d/init.d/httpd
> > 
> > daemon chroot /jail/ su httpd -c $httpd $OPTIONS
> > 

Thank you, Michael.
It's a nice article, but I'm using RedHat Linux 9.

It was very easy building chroot environment, for
I used a custom kernel that lists up files which are needed.
(I want to publish the patch, but I made it on business,
permission to publish is not given yet. I'm sorry.)

Only I can't do is 'chroot /jail/ su httpd -c' by one program.
