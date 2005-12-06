Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbVLFCud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbVLFCud (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 21:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbVLFCud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 21:50:33 -0500
Received: from fsmlabs.com ([168.103.115.128]:22228 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751401AbVLFCuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 21:50:32 -0500
X-ASG-Debug-ID: 1133837429-25466-47-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Mon, 5 Dec 2005 18:56:05 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Serge Noiraud <serge.noiraud@bull.net>
cc: linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: APIC,  x86: How to change the IRQ of one board when BIOS can't
 ?
Subject: Re: APIC,  x86: How to change the IRQ of one board when BIOS can't
 ?
In-Reply-To: <200512051034.46954.Serge.Noiraud@bull.net>
Message-ID: <Pine.LNX.4.64.0512051851380.19959@montezuma.fsmlabs.com>
References: <200512051034.46954.Serge.Noiraud@bull.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.60
X-Barracuda-Spam-Status: No, SCORE=0.60 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=COMMA_SUBJECT
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6000
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.60 COMMA_SUBJECT          Subject is like 'Re: FDSDS, this is a subject'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2005, Serge Noiraud wrote:

> I get sometimes an APIC error on CPU 1. for IRQ 169, I get 4 modules : 3 USB 
> and one Nvidia ( I know, you dislike that). I would like to affect another 
> IRQ to the nvidia card to see if the problem is nvidia or not. I don't want 
> to modify the others IRQ.
> I can't from the BIOS. I red Documentation/i386/IO-APIC.txt but I'm not sure 
> it is possible.
> What is the best method to do that ? is pirq the solution ? how ?

This most likely has nothing to do with the interrupt routing, do the APIC  
errors occur when you boot with 'noapic'? Also what are the two numbers 
after the APIC error?
