Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276646AbRJ2STM>; Mon, 29 Oct 2001 13:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278690AbRJ2STC>; Mon, 29 Oct 2001 13:19:02 -0500
Received: from fungus.teststation.com ([212.32.186.211]:267 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S276646AbRJ2SSt>; Mon, 29 Oct 2001 13:18:49 -0500
Date: Mon, 29 Oct 2001 19:17:50 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Smbfs + preempt on 2.4.10
In-Reply-To: <01102919120800.05333@nemo>
Message-ID: <Pine.LNX.4.30.0110291913490.21339-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, vda wrote:

> Hi,
> 
> I narrowed down Samba weirdness I observe on 2.4.10 to preempt patch.
> Plain 2.4.10 works fine, 2.4.10+preempt (with latency measurement turned on)
> is sometimes oopses, and sometimes reports 'file already exists' when I 
> attempt to copy a file from WinNT box to Linux. Sometimes it works ok
> (50% or so...)

Could be that the preempt patch triggers some smbfs bug. Where do I get a
copy of it?

It is of course also possible that the preempt patch is buggy, in which
case I don't really care :)


> I am very willing to help in curing this coz low latency is great.

Could you describe the problems you experience with the current code, and
how the preempt patch helps?

/Urban

