Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287684AbSANQoW>; Mon, 14 Jan 2002 11:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287681AbSANQoM>; Mon, 14 Jan 2002 11:44:12 -0500
Received: from sun.fadata.bg ([80.72.64.67]:15373 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S287626AbSANQn7>;
	Mon, 14 Jan 2002 11:43:59 -0500
To: yodaiken@fsmlabs.com
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu>
	<3C41A545.A903F24C@linux-m68k.org>
	<20020113153602.GA19130@fenrus.demon.nl>
	<E16PzHb-00006g-00@starship.berlin>
	<20020113223438.A19324@hq.fsmlabs.com> <87bsfx9led.fsf@fadata.bg>
	<20020114064548.D22065@hq.fsmlabs.com>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <20020114064548.D22065@hq.fsmlabs.com>
Date: 14 Jan 2002 18:36:57 +0200
Message-ID: <87k7ukyjme.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "yodaiken" == yodaiken  <yodaiken@fsmlabs.com> writes:
yodaiken> current scheme, this becomes more complex. And with preempt, you cannot even offer the
yodaiken> assurance that once a process gets the cpu it will make _any_ advance at all.

So? It either shouldn't have got the CPU anyway (maybe it CPU is
needed for other things) or user's priority setup is seriously borked.

The scheduling policies, algorithms, mechanisms, whatever ... do not
guarantee schedulability by themselves.

