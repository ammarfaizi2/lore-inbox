Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317318AbSGIGp5>; Tue, 9 Jul 2002 02:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317320AbSGIGp4>; Tue, 9 Jul 2002 02:45:56 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:23948 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S317318AbSGIGpz>; Tue, 9 Jul 2002 02:45:55 -0400
Date: Tue, 9 Jul 2002 08:48:25 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Tim Alexeevsky <realtim@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: File accessing.
Message-ID: <20020709064825.GA32293@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Tim Alexeevsky <realtim@mail.ru>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0207070206140.213-100000@zhuchka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0207070206140.213-100000@zhuchka>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 02:40:26AM +0400, Tim Alexeevsky wrote:
...
>  Using strace I tracked this problem down to requesting
>  open("jffs2/gc.c", O_READONLY|O_LARGEFILE)
>  Now
>    ls jffs2
>   also gives me a kernel panic. It's on reiserfs.
> 

i'd suggest you start your next day/night with reiserfsck --fix-fixable.
And you'll have to upgrade your reiserfsprogs up to 3.x.1b.

-alex
