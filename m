Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbRETSWK>; Sun, 20 May 2001 14:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261418AbRETSWA>; Sun, 20 May 2001 14:22:00 -0400
Received: from mnh-1-12.mv.com ([207.22.10.44]:14855 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S261302AbRETSVt>;
	Sun, 20 May 2001 14:21:49 -0400
Message-Id: <200105201934.OAA02757@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Dave Airlie <airlied@skynet.ie>
cc: linux-vax@mithra.physics.montana.edu, linux-kernel@vger.kernel.org
Subject: Re: start_thread question... 
In-Reply-To: Your message of "Sun, 20 May 2001 17:24:48 +0100."
             <Pine.LNX.4.32.0105201717100.29656-100000@skynet> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 May 2001 14:34:53 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

airlied@skynet.ie said:
> I'm implementing start_thread for the VAX port and am wondering does
> start_thread have to return to load_elf_binary? I'm working on the
> init thread and what is happening is it is returning the whole way
> back to the execve caller .. which I know shouldn't happen.....

Ingo answered that specific question (and that had me puzzled for a while, too 
:-), but, in the future, you might want to look at UML if you have similar 
questions.  All this stuff works, and it's implemented in terms of the system 
calls that we all know and love, so you don't have to learn about a totally 
different piece of hardware in order to figure out what's going on.

				Jeff


