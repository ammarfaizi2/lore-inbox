Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTILRpa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbTILRpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:45:30 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:52608
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261775AbTILRpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:45:25 -0400
Date: Fri, 12 Sep 2003 13:45:14 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Another keyboard woes with 2.6.0...
In-Reply-To: <20030912165044.GA14440@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.53.0309121341380.6886@montezuma.fsmlabs.com>
References: <20030912165044.GA14440@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003, Petr Vandrovec wrote:

>    I have MicroStar MS-9211 box with connected to the KVM switch
> MasterView CS-1016, which is connected to the some Chicony
> keyboard. 2.4.x kernel works without problem, but when 2.6.0
> starts, immediately after input device driver is initialized it starts
> thinking that F7 key is held down, and it stays that way until
> I hit some other key to stop autorepeat... What debugging I
> can do for you to get rid of screen full of '^[[18~' ? /bin/login
> continuously complains about username being too long :-(

Hi Petr,
	I have the same problem with an Avocent SwitchView and Keytronic 
keyboard, although it doesn't sound as bad as your problem. Occasionally 
some keys just repeat until i press another key. I'm not quite sure what 
kind of information Vojtech would like. The machine is 440BX based and 
kernel is 2.6.0-test3-mm1

          CPU0       CPU1
  0:  257421453  254104517    IO-APIC-edge  timer
  1:     424923     422774    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:     228634     228311    IO-APIC-edge  serial
  4:     116114     113964    IO-APIC-edge  serial
  8:   13986431   13605977    IO-APIC-edge  rtc
 12:    1836529    1831055    IO-APIC-edge  i8042
 14:    8919333    8754830    IO-APIC-edge  ide0
 15:    8852308    8762306    IO-APIC-edge  ide1
 16:   22023199   21397513   IO-APIC-level  radeon@PCI:1:0:0
 18:   11117225   10991498   IO-APIC-level  aic7xxx, aic7xxx, EMU10K1
 19:   10331810   10340569   IO-APIC-level  uhci-hcd, eth0, eth1
NMI:          0          0
LOC:  511599000  511599061
