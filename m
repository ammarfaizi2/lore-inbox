Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262291AbSJ1MEo>; Mon, 28 Oct 2002 07:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSJ1MEo>; Mon, 28 Oct 2002 07:04:44 -0500
Received: from dsl-213-023-020-012.arcor-ip.net ([213.23.20.12]:57539 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262291AbSJ1MEn>;
	Mon, 28 Oct 2002 07:04:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Luca Barbieri <ldb@ldb.ods.org>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] x86 multiple user-mode privilege rings
Date: Mon, 28 Oct 2002 13:12:02 +0100
X-Mailer: KMail [version 1.3.2]
References: <1035686893.2272.20.camel@ldb>
In-Reply-To: <1035686893.2272.20.camel@ldb>
Cc: Karim Yaghmour <karim@opersys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E1868kU-0002cQ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 October 2002 03:48, Luca Barbieri wrote:
> Short explaination: 
> This patch implements a feature called "x86 multiring", which is a
> shorthand for x86 multiple user-mode privilege rings support. 
> It allows user-mode programs to create DPL 1 and 2 segments and get a
> modifiable per-process copy of IDT. 
> 
> User Mode Linux can use these features to implement a syscall mechanism
> identical to the one used by the kernel-mode kernel, and thus much
> faster than the current one, with free memory protection and with zero
> context switches. 
> 
> Wine could also use it to achieve fast syscall-level emulation of
> Windows NT (and, to a lesser extent, Windows 3.1 and 9x). 

Karim once talked about doing a flavor of Adeos that would drop a running 
kernel into ring 1 as a result of insmodding an Adeos module, which would 
allow Adeos to combine an unmodified Linux kernel with a realtime executive.

-- 
Daniel
