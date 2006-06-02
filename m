Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWFBIeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWFBIeb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWFBIeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:34:31 -0400
Received: from quechua.inka.de ([193.197.184.2]:23452 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751330AbWFBIea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:34:30 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: printk's - i dont want any limit howto?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <8bf247760606020037x7eedab52qa9c736bdba740cb8@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1Fm56x-0007Mb-00@calista.eckenfels.net>
Date: Fri, 02 Jun 2006 10:34:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram <vshrirama@gmail.com> wrote:
>  Actually even though the printks are getting executed.
>  ONLY some appear. I have given both KERN_ERR and KERN_DEBUG

do u use "dmesg" to see them? so you do not have to be sure your syslog is
logging them (and not aggregating some).

>   i have given printk_ratelimit_burst= 1000 ; printk_ratelimit_jiffies = 0 ;

If ratelimit is the problem I think it will write a message that you missed
some output as level warning. So it is unlikely the issue.

Gruss
Bernd
