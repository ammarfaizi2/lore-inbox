Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293164AbSCRWnU>; Mon, 18 Mar 2002 17:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293162AbSCRWnH>; Mon, 18 Mar 2002 17:43:07 -0500
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:40835
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S293164AbSCRWk4>; Mon, 18 Mar 2002 17:40:56 -0500
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200203182242.g2IMgx119637@www.hockin.org>
Subject: Re: [PATCH] Scalable CPU bitmasks
To: manfred@colorfullife.com (Manfred Spraul)
Date: Mon, 18 Mar 2002 14:42:59 -0800 (PST)
Cc: rweight@us.ibm.com (Russ Weight), linux-kernel@vger.kernel.org
In-Reply-To: <001e01c1cecc$50c347f0$010411ac@local> from "Manfred Spraul" at Mar 18, 2002 11:28:47 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  NOTE:   The cpumap_to_ulong() and cpumap_ulong_to_cpumap() interfaces
> >          are provided specifically for migration. In their current
> >          form, they call BUG() if NR_CPUS is defined to be greater
> >          than the bit-size of (unsigned long).
> 
> Why BUG? NR_CPUS is known at compile time,  is there a reason why you
> can't use a call to an undefined function in order to get a link time
> error message? (like __bad_udelay in linux/asm-i386/udelay.h)

why that, rather than #error ?



