Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262445AbSI2LOC>; Sun, 29 Sep 2002 07:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSI2LOC>; Sun, 29 Sep 2002 07:14:02 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:64188 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262445AbSI2LOB>; Sun, 29 Sep 2002 07:14:01 -0400
Date: Sun, 29 Sep 2002 07:19:18 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: v2.6 vs v3.0
Message-ID: <20020929111918.GA1639@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209281826050.2198-100000@home.transmeta.com> <200209290716.g8T7GNwf000562@darkstar.example.net> <20020929091229.GA1014@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929091229.GA1014@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 11:12:29AM +0200, Jens Axboe wrote:
> On Sun, Sep 29 2002, jbradford@dial.pipex.com wrote:
> > > Anyway, people who are having VM trouble with the current 2.5.x series, 
> > > please _complain_, and tell what your workload is. Don't sit silent and 
> > > make us think we're good to go.. And if Ingo is right, I'll do the 3.0.x 
> > > thing.
> > 
> > I think the broken IDE in 2.5.x has meant that it got seriously less
> > testing overall than previous development trees :-(.  Maybe after
> > halloween when it stabilises a bit more we'll get more reports in.
> 
> 2.5 is definitely desktop stable, so please test it if you can. Until
> recently there was a personal show stopper for me, the tasklist
> deadline. Now 2.5 is happily running on my desktop as well.
> 
> 2.5 IDE stability should be just as good as 2.4-ac.
> 
Hmm - our definitions must be different.

ASUS P4S533 (SiS645DX chipset)
P4 2Ghz
1G PC2700 RAM

Disable SMP, enable APIC & IO APIC
Get "WARNING - Unexpected IO APIC found"
system freezes

Disable IO APIC, enable ACPI
system detects ACPI, builds table, freezes.

Disable ACPI, enable ide-scsi in the kernel
kernel panic analyzing hdc

None of these have been reported because I haven't had time to do all the
work involved in making a report that anyone on the team will read.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.openprojects.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

