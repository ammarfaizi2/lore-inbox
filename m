Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279372AbRJ2Sz7>; Mon, 29 Oct 2001 13:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279377AbRJ2Szt>; Mon, 29 Oct 2001 13:55:49 -0500
Received: from freeside.toyota.com ([63.87.74.7]:47884 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S279372AbRJ2Szj>;
	Mon, 29 Oct 2001 13:55:39 -0500
Message-ID: <3BDDA646.B5D0E526@lexus.com>
Date: Mon, 29 Oct 2001 10:56:06 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Smbfs + preempt on 2.4.10
In-Reply-To: <01102919120800.05333@nemo>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda wrote:

> Hi,
>
> I narrowed down Samba weirdness I observe on 2.4.10 to preempt patch.
> Plain 2.4.10 works fine, 2.4.10+preempt (with latency measurement turned on)
> is sometimes oopses, and sometimes reports 'file already exists' when I
> attempt to copy a file from WinNT box to Linux. Sometimes it works ok
> (50% or so...)
>

There were highmem bugs in older preempt patch.
I had lockups on a prempt kernel compaq 6500 that
were cured in 2.4.13 or so...

Why not try a recent kernel + preempt?

cu

jjs

