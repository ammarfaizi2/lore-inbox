Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262841AbUKXUYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262841AbUKXUYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbUKXUWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:22:31 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:49848 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262831AbUKXUVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:21:04 -0500
Subject: Re: Suspend 2 merge: 19/51: Remove MTRR sysdev support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411240922570.7171@musoma.fsmlabs.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101295453.5805.263.camel@desktop.cunninghams>
	 <Pine.LNX.4.61.0411240922570.7171@musoma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1101327166.3425.4.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 07:17:24 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-11-25 at 03:27, Zwane Mwaikambo wrote:
> On Wed, 24 Nov 2004, Nigel Cunningham wrote:
> 
> > This patch removes sysdev support for MTRRs (potential SMP hang and
> > shouldn't be done with interrupts done anyway). Instead, we save and
> > restore MTRRs when entering and exiting the processor freezers (ie when
> > saving the registers & context for each CPU via an SMP call).
> 
> I take it this has been tested with AGP and X11 running?

Absolutely. It is used all the time. (The machine I'm typing on now has
HT support and I normally suspend from X - Radeon driver and just double
checked that agpgart is loaded).

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

