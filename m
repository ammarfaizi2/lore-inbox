Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311212AbSCPX6l>; Sat, 16 Mar 2002 18:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311213AbSCPX6c>; Sat, 16 Mar 2002 18:58:32 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:22988 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311212AbSCPX6Q>;
	Sat, 16 Mar 2002 18:58:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, ian@ianduggan.net (Ian Duggan)
Subject: Re: 2.4.18 Preempt Freezeups
Date: Sun, 17 Mar 2002 00:51:27 +0100
X-Mailer: KMail [version 1.3.2]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rml@tech9.net (Robert Love),
        linux-kernel@vger.kernel.org (linux kernel)
In-Reply-To: <E16lshA-0003lX-00@the-village.bc.nu>
In-Reply-To: <E16lshA-0003lX-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16mNxQ-0000mM-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 15, 2002 03:28 pm, Alan Cox wrote:
> > What is required for preempt beyond "SMP safe" code? I thought the whole
> > idea was to make the preemptions transparent to other code by utilizing
> > the SMP critical regions?
> 
> SMP safe code
> Actual source code when recompiling modules
> Reviewing things like driver code use of disable_irq by hand
> Reviewing driver code for situations where it requires a small timing delay
> 	and a large one is unacceptable

Has anyone found one of those yet?

> Checking anywhere you use the cpu id that you don't do somthing where it
> 	might change under you (eg per cpu variables)

Is per-cpu data the whole list there?

-- 
Daniel
