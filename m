Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSLUSCV>; Sat, 21 Dec 2002 13:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSLUSCV>; Sat, 21 Dec 2002 13:02:21 -0500
Received: from dsl-213-023-066-023.arcor-ip.net ([213.23.66.23]:13964 "EHLO
	neon.pearbough.net") by vger.kernel.org with ESMTP
	id <S262838AbSLUSCU>; Sat, 21 Dec 2002 13:02:20 -0500
Date: Sat, 21 Dec 2002 19:08:52 +0100
From: axel@pearbough.net
To: Ro0tSiEgE <lkml@ro0tsiege.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel GCC Optimizations
Message-ID: <20021221180852.GA31293@neon.pearbough.net>
Mail-Followup-To: Ro0tSiEgE <lkml@ro0tsiege.org>,
	linux-kernel@vger.kernel.org
References: <200212211135.10289.lkml@ro0tsiege.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212211135.10289.lkml@ro0tsiege.org>
User-Agent: Mutt/1.4i
Organization: pearbough.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ro0tSiEgE!

On Sat, 21 Dec 2002, Ro0tSiEgE wrote:

> Is there any risk using -O3 instead of -O2 to compile the kernel, and why?
>  Also what about compiling against glibc 2.3.1 and gcc 3.2.x??

I believe because of some assembler stuff that needs to be compiled as is and
may not be optimized more that -O2 you cannot use -O3.

There is no problem compiling the kernel with glibc 2.3.1 and gcc 3.2.x.

Axel
