Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287145AbSAUPfq>; Mon, 21 Jan 2002 10:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287148AbSAUPfg>; Mon, 21 Jan 2002 10:35:36 -0500
Received: from dsl-213-023-039-080.arcor-ip.net ([213.23.39.80]:3977 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287145AbSAUPfY>;
	Mon, 21 Jan 2002 10:35:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: yodaiken@fsmlabs.com, george anzinger <george@mvista.com>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 21 Jan 2002 16:38:59 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <3C439D02.EBCD78C4@mvista.com> <20020115053901.C32605@hq.fsmlabs.com>
In-Reply-To: <20020115053901.C32605@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16SgXE-0001i8-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 15, 2002 01:39 pm, yodaiken@fsmlabs.com wrote:
> My reservation about preemption as an implementation technique is that
> it has costs, which seem to be not easily boundable, but not very 
> clear benefits.

To me the benefit is clear enough: ASAP scheduling of IO threads, a simple 
heuristic that improves both throughput and latency.

--
Daniel
