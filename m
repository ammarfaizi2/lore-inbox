Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274799AbRIUTu3>; Fri, 21 Sep 2001 15:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274800AbRIUTuT>; Fri, 21 Sep 2001 15:50:19 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:9278 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274799AbRIUTuG>; Fri, 21 Sep 2001 15:50:06 -0400
Subject: Re: Feedback on preemptible kernel patch xfs
From: Robert Love <rml@tech9.net>
To: Gerold Jury <geroldj@grips.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200109211229.f8LCT9J19687@hal.grips.com>
In-Reply-To: <1000581501.32705.46.camel@phantasy>
	<3BA94B2E.99FABD43@grips.com> <1000947409.4348.58.camel@phantasy> 
	<200109211229.f8LCT9J19687@hal.grips.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.20.15.42 (Preview Release)
Date: 21 Sep 2001 15:50:29 -0400
Message-Id: <1001101835.7296.63.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-21 at 08:29, Gerold Jury wrote:
> On Thursday 20 September 2001 02:56, Robert Love wrote:
> > I am surprised, you should see a difference, especially with the
> > latencytest.  Silly question, but you both applied the patch and enabled
> > the config statement, right?
> >
> Really, i have checked twice.
> The patch could, by the way, write a line to the syslog when enabled.

OK, I believe you :)

Yes, but I find all the `NET4.0 loaded!' as crap as it is.  If
CONFIG_PREEMPT is defined, rest assured the code is correct.

> All the filesystem operations happend on the xfs partitions.
> I noticed more equally distributed read/write operations with smaller slices 
> during big copy jobs on xfs.
> This effect may well come from the preemption patch. I used a spare partition
> for the test, so the filesystem was in the same state with both kernels 
> during the tests.
> Xfs usually delays the write operations and does them in bigger blocks.
> The behavior of XFS has changed with the kernel versions towards this 
> direction anyway but is clearly different with the preemption patch.
> 
> I will redo the latency tests with the standard Xfree86 nvidia driver.
> It may give a different picture.
> The graphics test and the /proc test have shown the highest latency's.
> Both involve the xserver (proc for the xterm).
> The other tests have been around 5-6 msec in both cases.
> 
> And i will do the dbench test of course.

Very good. Please let me know.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

