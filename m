Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbVLFBHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVLFBHG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVLFBHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:07:06 -0500
Received: from mail.enyo.de ([212.9.189.167]:16095 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S964885AbVLFBHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 20:07:05 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Mark Lord <lkml@rtr.ca>,
       Rob Landley <rob@landley.net>, Adrian Bunk <bunk@stusta.de>,
       David Ranson <david@unsolicited.net>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de>
	<200512042131.13015.rob@landley.net> <4394681B.20608@rtr.ca>
	<1133800090.21641.17.camel@mindpipe>
	<20051205164418.GA12725@merlin.emma.line.org>
	<1133803048.21641.48.camel@mindpipe>
	<20051205175518.GA21928@merlin.emma.line.org>
	<873bl76zd3.fsf@mid.deneb.enyo.de>
	<1133817679.6724.52.camel@localhost.localdomain>
Date: Tue, 06 Dec 2005 02:06:33 +0100
In-Reply-To: <1133817679.6724.52.camel@localhost.localdomain> (Steven
	Rostedt's message of "Mon, 05 Dec 2005 16:21:19 -0500")
Message-ID: <87bqzv2fvq.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Steven Rostedt:

>> Would this alone change much?  I think what we really want is that our
>> favorite branch (whatever it is) gets critical fixes forever (well,
>> maybe one or two years, but this is forever).  This is a bit
>> unrealistic because everyone has a slightly different branchpoint.
>> Releasing more often doesn't change that, really.
>
> Maybe that is what is needed.  A branch that all can use.

There isn't a single one.  Even for Debian, it was a hard struggle to
get sown to just two (or three?).  Now try that across distributions,
or for people who own choosy hardware. (I once had to deal with a box
which didn't like anything else except 2.6.0-test9.  I believe it's
still running this version, maybe slightly patched.)

> Have every 5 or so 2.6.x become a "stable" branch.  Where
> distributions and users can work together on keeping it stable.  The
> rules to modifying such a branch would pretty much stay with what it
> already takes to modify the current 2.6.x.y branch.  If you want a
> feature, you must either take the latest "unstable" 2.6.x branch or
> wait for the next "stable" 2.6.x branch to merge.

In essence, this is just a slower version of the current model.  It
won't change that much, unless the speed of the development cycle (and
its phase) matches your needs, which is unlikely.  Security bugs would
still be discovered at about the same rate.
