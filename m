Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288643AbSAIAab>; Tue, 8 Jan 2002 19:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288646AbSAIAaW>; Tue, 8 Jan 2002 19:30:22 -0500
Received: from otter.mbay.net ([206.40.79.2]:28170 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S288643AbSAIAaM> convert rfc822-to-8bit;
	Tue, 8 Jan 2002 19:30:12 -0500
From: John Alvord <jalvo@mbay.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 08 Jan 2002 16:29:59 -0800
Message-ID: <1i3n3uct8fbh075ce99611tocgoe60oeqa@4ax.com>
In-Reply-To: <20020108173254.B9318@asooo.flowerfire.com> <E16O6KE-00087x-00@the-village.bc.nu>
In-Reply-To: <E16O6KE-00087x-00@the-village.bc.nu>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002 00:10:38 +0000 (GMT), Alan Cox
<alan@lxorguk.ukuu.org.uk> wrote:

>> Preemptive gives better interactivity under load, which is the whole
>> point of multitasking (think about it).  If you don't want the overhead
>> (which also exists without preemptive) run #processes == #processors.
>
>That is generally not true. Pe-emption is used in user space to prevent
>applications doing very stupid things. Pre-emption in a trusted environment
>can often be most efficient if done by the programs themselves.
>
>Userspace is not a trusted environment
The best part about planned preemption points is that there is minimal
state to save when an interruption occurs.

>
>> I'm really surprised that people are still actually arguing _against_
>> preemptive multitasking in this day and age.  This is a no-brainer in
>> the long run, where current corner cases aren't holding us back.
>
>Andrew's patches give you 1mS worst case latency for normal situations, that
>is below human perception, and below scheduling granularity. In other words
>without the efficiency loss and the debugging problems you can place the
>far enough latency below other effects that it isnt worth attacking any more.

Incidently human visual perception runs around 200 milliseconds
minimum and hearing/touch perception around 100 milliseconds if the
signal has to go through the brain. Of course we extend our
perceptions with tools/programs etc.

john
