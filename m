Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264228AbTKKDQp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 22:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264234AbTKKDQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 22:16:45 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:63715
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264228AbTKKDQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 22:16:44 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: davidsen@tmr.com (bill davidsen), linux-kernel@vger.kernel.org
Subject: Re: Post-halloween doc updates.
Date: Mon, 10 Nov 2003 19:09:09 -0600
User-Agent: KMail/1.5
References: <20031030141519.GA10700@redhat.com> <9cfn0bhjswn.fsf@rogue.ncsl.nist.gov> <bop7rf$7rd$1@gatekeeper.tmr.com>
In-Reply-To: <bop7rf$7rd$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311101909.09337.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 November 2003 17:43, bill davidsen wrote:
> In article <9cfn0bhjswn.fsf@rogue.ncsl.nist.gov>,
>
> Ian Soboroff  <ian.soboroff@nist.gov> wrote:
> | Well, ok, but the alternatives are ACPI, which has always been spotty,
> | and two competing power management schemes from Patrick and Pavel,
> | neither of which seem to actually work yet.  Wouldn't it be nice to
> | have at least one working method of putting a laptop to sleep?
>
> I have no problem putting the laptop to sleep. On the other hand, waking
> it up...

Which suspend version are you using?  echo -n "4">/proc/acpi/something or echo 
-n "disk" > sys/power/state?

The second works for me (for a slightly malleable value of "works": resume has 
never failed on me, suspend works maybe 9 times out of 10, and either 
immediately resumes without power down (apparently with no harm done, it just 
didn't work) or panics the rest of the time).

The first has never come close to working (for me).

Rob
