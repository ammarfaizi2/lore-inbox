Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbTAVMfB>; Wed, 22 Jan 2003 07:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbTAVMfB>; Wed, 22 Jan 2003 07:35:01 -0500
Received: from chaos.analogic.com ([204.178.40.224]:60046 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267449AbTAVMfB>; Wed, 22 Jan 2003 07:35:01 -0500
Date: Wed, 22 Jan 2003 07:45:36 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Electroniks New <elektr_new@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: sleep in asm
In-Reply-To: <20030122113050.65639.qmail@web14707.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1030122074458.25637B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Electroniks New wrote:

> Hi,
>   What is the equivalent of sleep in assembly.
>   I tried jmps and nops i even kept loops.for jumps
> and nops but all in vain .
>   Does it make any difference if i am doing this real
> mode instead of pmode ? doesnt the functions nop and
> jmps   do what they are supposed to do . 16000 nops
> doesn't sleep for 1 sec.
> 
> Any help would be appreciated. 

	hlt		# Waits until the next interrupt


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


