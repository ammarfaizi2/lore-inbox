Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288411AbSANJD7>; Mon, 14 Jan 2002 04:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288595AbSANJDu>; Mon, 14 Jan 2002 04:03:50 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:29825
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288411AbSANJDl>; Mon, 14 Jan 2002 04:03:41 -0500
Date: Mon, 14 Jan 2002 03:48:31 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
Message-ID: <20020114034831.A5780@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020113205839.A4434@thyrsus.com> <m1k7ulpbf7.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1k7ulpbf7.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Jan 14, 2002 at 01:46:36AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com>:
> ISA is not a software enumerable bus especially not for unprivledged
> users.  And no amount of complaining will change that.  That is why we
> have PNP ISA and PCI.

But the kernel itself has to know how to probe and initialize these devices
at boot time, correct?  That information is implicitly exported via
/var/log/dmesg -- I'm simply suggesting that it be a little more explicit.

> > But suppose the format of boot-time driver messages were standardized in a
> > format that included their config symbol in a discoverable form?
> 
> If there was an ISA device in your example it might be interesting.

Some of the on-board devices on my Tyan Thunder are ISA.

> > With this change, generating a report on ISA hardware and other
> > facilities configured in at boot time would be trivial.  This would
> > make the autoconfigurator much more capable.  Best of all, the only
> > change required to accomplish this would be safe edits of print format
> > strings.
> 
> It sounds like what you want is an lsmod that lists compiled in
> modules.

Would that be feasible without root privileges in order to read kmem?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

[The disarming of citizens] has a double effect, it palsies the hand
and brutalizes the mind: a habitual disuse of physical forces totally
destroys the moral [force]; and men lose at once the power of
protecting themselves, and of discerning the cause of their
oppression.
        -- Joel Barlow, "Advice to the Privileged Orders", 1792-93
