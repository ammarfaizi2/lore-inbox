Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287697AbSANQoc>; Mon, 14 Jan 2002 11:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287626AbSANQoW>; Mon, 14 Jan 2002 11:44:22 -0500
Received: from sun.fadata.bg ([80.72.64.67]:14605 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S287658AbSANQoE>;
	Mon, 14 Jan 2002 11:44:04 -0500
To: Oliver.Neukum@lrz.uni-muenchen.de
Cc: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu>
	<20020113223438.A19324@hq.fsmlabs.com> <87bsfx9led.fsf@fadata.bg>
	<16Q6V6-207eimC@fwd06.sul.t-online.com>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <16Q6V6-207eimC@fwd06.sul.t-online.com>
Date: 14 Jan 2002 18:32:27 +0200
Message-ID: <87d70c51wk.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Oliver" == Oliver Neukum <520047054719-0001@t-online.de> writes:

Oliver> On Monday 14 January 2002 13:17, Momchil Velikov wrote:
>> >>>>> "yodaiken" == yodaiken  <yodaiken@fsmlabs.com> writes:
>> 
yodaiken> It's not even clear how preempt is supposed to interact with
>> SCHED_FIFO.
>> 
>> How so ? The POSIX specification is not clear enough or it is not to be
>> followed ?

Oliver> You can have an rt task block on a lock held by a normal task that was 
Oliver> preempted by a rt task of lower priority. The same problem as with the 
Oliver> sched_idle patches.

This can happen with a non-preemptible kernel too. And it has nothing to
do with scheduling policy.


