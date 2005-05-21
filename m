Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVEUTme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVEUTme (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 15:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVEUTmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 15:42:33 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:32461 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261611AbVEUTmS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 15:42:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KqtggDyH0ELTILAMTckCJH92BleeDx8RJ7qa4RXJKo38wt39+ggrFS83esmdn61fYPX+mjcQaEFev0lkjUEjZCHSp3TQHb9kPdCBTYXnD8pBTrtBCyoK8fEhe6/2Sv49moAzr6P9jZukhxXZFQFst6h9JqaNj58gRKX0CVppa9w=
Message-ID: <d93f04c705052112426ee35154@mail.gmail.com>
Date: Sat, 21 May 2005 21:42:16 +0200
From: Hendrik Visage <hvjunk@gmail.com>
Reply-To: Hendrik Visage <hvjunk@gmail.com>
To: Bernd Paysan <bernd.paysan@gmx.de>
Subject: Re: False "lost ticks" on dual-Opteron system (=> timer twice as fast)
Cc: suse-amd64@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <200505081445.26663.bernd.paysan@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200505081445.26663.bernd.paysan@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/05, Bernd Paysan <bernd.paysan@gmx.de> wrote:
> Hi,
> 
> I've recently set up a dual Opteron RAID server (AMD-8000-based Tyan
> Thunder K8S Pro SCSI board, 2 246 Opterons, stepping 10). Kernel is a
> modified 2.6.11.4-20a from SuSE 9.3 (SMP version, sure). The Opterons
> are capable of changing the CPU frequency (between 1GHz and 2GHz).

I'll be delving deeper into this thread soon, but I'm seeing similar
strangeness
on a Athlon64 (rated:3G+ real:2009MHz clock), 2.6.11-r8 (gentoo), MSI
K8N Neo Platinum.

ntp syncs time, then I start a couple of compiles, and I see ntp
losing track of time, big jitter etc. (and the one time source is in
on the local LAN syncing to the same remote servers). openntp I
noticed it also.

What I have noticed in my dmesg output is that I see "lost timer ticks
CPU Frequency change?" messages very early in the boot up.

> What I can't believe is that I'm the only one who has this problem.

I've seen this for about a week or three, and somehow I believe it
wasn't a problem before 2.6.11.

-- 
Hendrik Visage
