Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289228AbSANNLi>; Mon, 14 Jan 2002 08:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289231AbSANNL2>; Mon, 14 Jan 2002 08:11:28 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:63389 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289228AbSANNLM>; Mon, 14 Jan 2002 08:11:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: Momchil Velikov <velco@fadata.bg>, yodaiken@fsmlabs.com
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 13:45:40 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <20020113223438.A19324@hq.fsmlabs.com> <87bsfx9led.fsf@fadata.bg>
In-Reply-To: <87bsfx9led.fsf@fadata.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16Q6V6-207eimC@fwd06.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 January 2002 13:17, Momchil Velikov wrote:
> >>>>> "yodaiken" == yodaiken  <yodaiken@fsmlabs.com> writes:
>
> yodaiken> 	It's not even clear how preempt is supposed to interact with
> SCHED_FIFO.
>
> How so ? The POSIX specification is not clear enough or it is not to be
> followed ?

You can have an rt task block on a lock held by a normal task that was 
preempted by a rt task of lower priority. The same problem as with the 
sched_idle patches.

	Regards
		Oliver
