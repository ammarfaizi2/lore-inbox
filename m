Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264564AbTK0RtR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 12:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264572AbTK0RtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 12:49:17 -0500
Received: from main.gmane.org ([80.91.224.249]:7840 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264564AbTK0RtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 12:49:02 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Selecting CPU frequency on Asus P4M laptop
Date: Thu, 27 Nov 2003 18:48:59 +0100
Message-ID: <yw1xhe0pln1w.fsf@kth.se>
References: <yw1x65h5ddbn.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:aCiojax0sjbgfiCKV1IJYI2jjnU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) writes:

> I have an Asus M2E laptop with a 1.8 GHz P4M CPU.  Using the 'acpi'
> cpufreq driver, I can select between 1.8 GHz and 1.2 GHz, thereby
> changing the power consumption.  If I boot the machine with the AC
> adapter disconnected, it starts off at 1.2 GHz.  After that, I can
> lower it to 800 MHz using cpufreq.  In short, cpufreq will be able to
> choose among one of two pairs of frequencies, which depend on the
> status of the AC adapter at boot time.
>
> Is there any way to change which of these will be used after booting?

Update:

I ran a speed test, "openssl speed", in the various modes, and it gave
the same results whichever way the machine was booted.  It appears to
be reporting/detecting incorrect values when the AC adapter is
unplugged.  Switching speeds with cpufreq does change the actual speed
of the CPU.

-- 
Måns Rullgård
mru@kth.se

