Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKGWEB>; Tue, 7 Nov 2000 17:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129176AbQKGWDw>; Tue, 7 Nov 2000 17:03:52 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:38905 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S129130AbQKGWDj>; Tue, 7 Nov 2000 17:03:39 -0500
Date: Tue, 7 Nov 2000 14:02:23 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Chris Meadors <clubneon@hereintown.net>
cc: Ulrich Drepper <drepper@redhat.com>, root@chaos.analogic.com,
        kernel@kvack.org, "Dr. David Gilbert" <dg@px.uk.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
In-Reply-To: <Pine.LNX.4.21.0011021334170.83-100000@rc.priv.hereintown.net>
Message-ID: <Pine.LNX.4.21.0011071401280.4438-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This machine isn't even a Xeon, just a PIII CuMine on a ServerWorks HeIII
> chipset.

Strange, I've got a dual Katmai (non-Xeon) and notice the same...

           CPU0       CPU1       
  0:   95135438   95720832    IO-APIC-edge  timer
  1:     579101     572402    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:    1414912    1423496    IO-APIC-edge  serial
  5:    5563231    5551230    IO-APIC-edge  soundblaster
  9:          0          0    IO-APIC-edge  acpi
 10:   10945738   10944261   IO-APIC-level  eth0
 11:     696382     700477   IO-APIC-level  ide0, ide1
 12:    7251164    7251575    IO-APIC-edge  PS/2 Mouse
 13:          0          0          XT-PIC  fpu
 14:    3079238    3079438   IO-APIC-level  eth1
 15:        111        130   IO-APIC-level  bttv
NMI:  190856196  190856196 
LOC:  190858464  190858463 
ERR:          0

This cannot be good...

 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
