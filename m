Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVELPhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVELPhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 11:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVELPhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 11:37:10 -0400
Received: from alog0337.analogic.com ([208.224.222.113]:5608 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262034AbVELPhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 11:37:05 -0400
Date: Thu, 12 May 2005 11:35:49 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Need kernel patch to compile with Intel compiler
In-Reply-To: <377362e105051207461ff85b87@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0505121130030.31719@chaos.analogic.com>
References: <377362e105051207461ff85b87@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2005, Tetsuji "Maverick" Rai wrote:

> In this mailing list archive I found a discussion on how to compile
> kenrel 2.6.x with Intel C++ compiler, but it was a bit old, and only
> kernel patch for version 2.6.5 or around so can be found.   As mine is
> HT enabled, I want newer one.
>
> Does anyone know where to find it, or how to make it?
>
> regards,

The kernel is designed to be compiled with the GNU 'C' compler
supplied with every distribution. It uses a lot of __asm__()
statements and other GNU-specific constructions.

Why would you even attempt to convert the kernel sources to
be compiled with some other tools? Also C++ won't work because
the kernel is all about method, i.e., procedures. You need
a procedural compiler for most of it, not an object-oriented
one.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
