Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbTLMOlc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 09:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbTLMOlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 09:41:32 -0500
Received: from intra.cyclades.com ([64.186.161.6]:15036 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265045AbTLMOla
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 09:41:30 -0500
Date: Sat, 13 Dec 2003 12:33:45 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Jeremy Kusnetz <JKusnetz@nrtc.org>
Cc: Philippe Troin <phil@fifi.org>, <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.23 is freezing my systems hard after 24-48 hours
In-Reply-To: <F7F4B5EA9EBD414D8A0091E80389450569D3CD@exchange.nrtc.coop>
Message-ID: <Pine.LNX.4.44.0312131103030.1273-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Dec 2003, Jeremy Kusnetz wrote:

> > Have you tried running with the NMI watchdog? I cannot run it myself
> > because I have to disable APIC support since my motherboard is
> > buggy. To do so, try booting with "nmi_watchdog=1" or "nmi_watchdog=2"
> > depending on your configuration. Check Documentation/nmi_watchdog.txt
> > for details.  Also verify that the NMI oopser works by checking for a
> > non-zero NMI count in /proc/interrupts.
> 
> Wish I knew about that earlier, unfortunately I've gone back to the
> 2.4.22 kernel as these are production boxes and I can't afford any more
> of these outages.  Besides I'm tired of getting paged at 4am :)  I wish
> I could get my development boxes to have this problem since it's not a
> big deal if they go down.

Are you using netfilter? There is a known netfilter hang problem.

What workload you have on the production boxes? (what is running, etc)

Can you show us a complete hardware list, /proc/interrupts output, 
.config and dmesg?

Trying to reproduce the oops on the development boxes with NMI watchdog 
turned on might also help a lot.



> What kind of hardware are you running?  These are Compaq DL360 G1 servers.

Philippe, can you point to your archived report message? I dont seem to 
have it around.




