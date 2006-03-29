Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWC2AbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWC2AbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWC2AbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:31:11 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:43956 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750716AbWC2AbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:31:10 -0500
Date: Tue, 28 Mar 2006 19:34:46 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: realtime-preempt 2.6.16-rt7-10 bug?
In-reply-to: <1143585658.11792.113.camel@mindpipe>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       "Shayne O'Connor" <machine@machinehasnoagenda.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, ardour-dev@lists.ardour.org
Reply-to: paul@linuxaudiosystems.com
Message-id: <1143592486.3402.3.camel@localhost.localdomain>
Organization: Linux Audio Systems
MIME-version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7)
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1143559994.2959.5.camel@machine>
	<1143579439.12960.5.camel@localhost.localdomain>
	<1143585658.11792.113.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 17:40 -0500, Lee Revell wrote:
> On Tue, 2006-03-28 at 15:57 -0500, Steven Rostedt wrote:
> > On Wed, 2006-03-29 at 02:33 +1100, Shayne O'Connor wrote:
> > > i've compiled the 2.6.16 kernel with the realtime-preempt patches, but
> > > have run into some problems while using Ardour for realtime audio.
> > > Ardour crashes whenever i stop recording, and after running dmesg i'm
> > > suspecting a bug in the realtime patch (i've tried rt7 and rt10, both
> > > have the same problem):
> > > 
> > 
> > Hmm, this may be a bug in Ardour.  Since it's for realtime audio, I
> > assume that it knows about the timeofday hack, which is the only way to
> > get this bug.  

Ardour does not use this hack. Only if you were using a JACK built to do
this could you see this.

> Specifically it unlinked a file.
> 
> Shayne, is your /tmp a tmpfs or ext3?


