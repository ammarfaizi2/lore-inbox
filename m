Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSGILpT>; Tue, 9 Jul 2002 07:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSGILpT>; Tue, 9 Jul 2002 07:45:19 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:14517 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S315119AbSGILpS>; Tue, 9 Jul 2002 07:45:18 -0400
Date: Tue, 9 Jul 2002 13:47:49 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Tim Alexeevsky <realtim@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: File accessing.
Message-ID: <20020709114749.GB32293@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Tim Alexeevsky <realtim@mail.ru>,
	linux-kernel@vger.kernel.org
References: <20020709064825.GA32293@riesen-pc.gr05.synopsys.com> <Pine.LNX.4.33.0207091326550.390-100000@zhuchka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0207091326550.390-100000@zhuchka>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 01:47:41PM +0400, Tim Alexeevsky wrote:
> Hello,
> 
> Today Alex Riesen wrote:
> 
> AR>On Sun, Jul 07, 2002 at 02:40:26AM +0400, Tim Alexeevsky wrote:
> AR>...
> AR>>  Using strace I tracked this problem down to requesting
> AR>>  open("jffs2/gc.c", O_READONLY|O_LARGEFILE)
> AR>>  Now
> AR>>    ls jffs2
> AR>>   also gives me a kernel panic. It's on reiserfs.
> AR>>
> AR>
> AR>i'd suggest you start your next day/night with reiserfsck --fix-fixable.
>    Sure :)
> 
> AR>And you'll have to upgrade your reiserfsprogs up to 3.x.1b.
>    Ok.
> 
>    But if this is the reason for this subproblem, there are some others
> and they all seem to appear simultaneously. They all are the problems with
> accessing files. And as long as I got the first problem I will have a
> lots of them on different filesystems until I reboot the system (AFAIK).
>    Maybe the reason is some damage in global filesystem handling. (Is that
> VFS?)

that's not the reason 8-) That are consequences.
Maybe upgrade the kernel as well? 2.4.19-rc1 seems to be quiet stable
for me and there was some changes to reiserfs since 2.4.17.

