Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTEVRYK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 13:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTEVRYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 13:24:10 -0400
Received: from ns2.jaj.com ([66.93.21.106]:42684 "EHLO ns2.jaj.com")
	by vger.kernel.org with ESMTP id S262830AbTEVRYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 13:24:09 -0400
Date: Thu, 22 May 2003 13:37:11 -0400
From: Phil Edwards <phil@jaj.com>
To: Justin Cormack <justin@street-vision.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 SMP, a PDC20269, and a huge Maxtor disk.  Am I doomed?
Message-ID: <20030522173711.GA22728@disaster.jaj.com>
References: <20030522134847.GA20179@disaster.jaj.com> <1053620457.1458.45.camel@lotte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053620457.1458.45.camel@lotte>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 05:20:56PM +0100, Justin Cormack wrote:
> Also, to isolate things, can you
> not use master and slave. I dont think they should be able to run at
> different speeds.

My (limited) understanding is that they /should/ (i.e., according to theory)
be able to, but that they might not /ought/ to (i.e., what the kernel
actually supports).  I've been meaning to get another ide cable anyway.  :-)


> Check /proc/interrupts. Are there lots of ERR interrupts listed? Thats
> what has happaned with my 2 systems, all was well for a while, then they
> started giving errors, and flaking out in nasty (different) ways. They
> are raid5 systems, which causes all sorts of fun as they get taken off
> line, and then come back and try to rebuild etc.

No ERRs at all here.

I am beginning to notice a pattern:  if the system is soft-rebooted, the
errors in my oridinal email almost always occur during the boot sequence
(which either hangs the system, or OOPSes the kernel).  Driving over to
that building, reaching down and pushing the reset button hasn't (yet) had
a problem.  I'll try to keep notes during the upcoming inevitable crashes.


> What motherboard do you have?

Tyan Tiger MP, the S2460 model.


Phil

-- 
If ye love wealth greater than liberty, the tranquility of servitude greater
than the animating contest for freedom, go home and leave us in peace.  We seek
not your counsel, nor your arms.  Crouch down and lick the hand that feeds you;
and may posterity forget that ye were our countrymen.            - Samuel Adams
