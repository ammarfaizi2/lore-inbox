Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311335AbSCLVSG>; Tue, 12 Mar 2002 16:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311346AbSCLVR4>; Tue, 12 Mar 2002 16:17:56 -0500
Received: from ns.suse.de ([213.95.15.193]:51723 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311335AbSCLVRs>;
	Tue, 12 Mar 2002 16:17:48 -0500
To: Steffen Persvold <sp@scali.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel profiling
In-Reply-To: <3C8E5712.20E5E317@scali.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Mar 2002 22:17:41 +0100
In-Reply-To: Steffen Persvold's message of "12 Mar 2002 20:36:15 +0100"
Message-ID: <p73bsdtxz7u.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Persvold <sp@scali.com> writes:

> List readers,
> 
> Is it possible to use the kernel profiling functionality to do profiling on loadable modules ? If
> no, is there any other easy method ?

Either compile the module in or use oprofile (http://oprofile.sourceforge.net)
The later is better, because it is a much more powerful profiler than 
the builtin one. 

-Andi
