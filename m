Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287827AbSANSnD>; Mon, 14 Jan 2002 13:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288787AbSANSm5>; Mon, 14 Jan 2002 13:42:57 -0500
Received: from [66.89.142.2] ([66.89.142.2]:39975 "EHLO starship.berlin")
	by vger.kernel.org with ESMTP id <S287827AbSANSlr>;
	Mon, 14 Jan 2002 13:41:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: yodaiken@fsmlabs.com, Momchil Velikov <velco@fadata.bg>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 19:43:59 +0100
X-Mailer: KMail [version 1.3.2]
Cc: yodaiken@fsmlabs.com, Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <87k7ukyjme.fsf@fadata.bg> <20020114030925.A1363@viejo.fsmlabs.com>
In-Reply-To: <20020114030925.A1363@viejo.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16QC5P-0000nO-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 14, 2002 10:09 am, yodaiken@fsmlabs.com wrote:
> UNIX generally tries to ensure liveness. So you know that
> 	cat lkarchive | grep feel | wc
> will complete and not just that, it will run pretty reasonably because
> for UNIX _every_ process is important and gets cpu and IO time.
> When you start trying to add special low latency tasks, you endanger
> liveness.  And preempt is especially corrosive because one of the 
> mechanisms UNIX uses to assure liveness is to make sure that once a 
> process starts it can do a significant chunk of work.

You're claiming that preemption by nature is not Unix-like?

--
Daniel
