Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbTCEUnt>; Wed, 5 Mar 2003 15:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbTCEUnt>; Wed, 5 Mar 2003 15:43:49 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:45792 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S262452AbTCEUnt>; Wed, 5 Mar 2003 15:43:49 -0500
Date: Wed, 5 Mar 2003 15:54:20 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Local APIC support interacting badly with cardbus/orinoco
Message-ID: <20030305205420.GA3765@delft.aura.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030305063801.GB25599@delft.aura.cs.cmu.edu> <15973.63728.763833.140185@gargle.gargle.HOWL> <20030305161239.GA21465@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305161239.GA21465@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.3i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 11:12:39AM -0500, Jan Harkes wrote:
> I am running 2.5.64 without Local APIC support and it seems to work.
> I'll rebuild with Local APIC, which clearly shouldn't make a difference
> because my CPU doesn't have one and see if the problem returns.

2.5.64 with Local APIC support enabled has already locked me out of my
system 3 times in less than 3 hours. Interestingly enough, it looks like
only the keyboard and the pcmcia slots are getting disabled, the power
led on the wavelan card turns off. A compile that was running just
continued on without a problem and the sysrq-unmount/sync/boot all
worked fine. So display and harddrive were fine.

Did not have any problem all morning when Local APIC support was not
enabled. Perhaps it can't be the problem because my cpu lacks the apic
in the first place, but it sure looks like it is related. I will run
without Local APIC support for a couple of hours now to make sure that
I wasn't just lucky this morning.

Jan

