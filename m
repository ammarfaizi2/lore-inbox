Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264732AbTFLEgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 00:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264733AbTFLEgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 00:36:21 -0400
Received: from jadzia.bu.edu ([128.197.20.189]:1957 "EHLO jadzia.bu.edu")
	by vger.kernel.org with ESMTP id S264732AbTFLEgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 00:36:20 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Pentium M (Centrino) cpufreq device driver (please test me)
In-Reply-To: <20030611230037$61cf@gated-at.bofh.it>
References: <20030611230037$61cf@gated-at.bofh.it>
Reply-To: mattdm@mattdm.org
Date: Thu, 12 Jun 2003 00:50:05 -0400
Message-Id: <20030612045005.3883C720B1@jadzia.bu.edu>
From: mattdm@jadzia.bu.edu (Matthew Miller)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The driver uses built-in tables for all the operating points of known
> Pentium M processors, derived from the Table 5 in the Intel Pentium M
> datasheet (25261202.pdf).  The tables derived from the datasheet exactly
> match the tables in ACPI on my 1.3GHz Pentium M IBM ThinkPad X31.
> 
> Because this driver is using undocumented registers, it is careful to
> only apply to CPUs which I'm confident that it will work with. 
> Therefore, not only does it look for the EST feature bit, but will only
> work on Family 6, Model 9, Stepping 5 processors.  It also needs an
> exact match on model name when choosing which operating point table to
> use.

For what it's worth (maybe not much) I have a Vaio U101 which uses the
"Celeron 600A" processor. This is a sort of bastard-child of the Pentium M
family -- it's not listed on their web site anywhere that I know of --
certainly not in the pdf documents -- and it doesn't have any SpeedStep
ability at all. (It's apparently locked 600Mhz and the lowest voltage. I
have't tried your patch to see what happens -- I can if you want.) Anyway, I
mention it because it *does* report itself as Family 6, Model 9, Stepping 5.
Model name is "Mobile Intel(R) Celeron(R) processor 600MHz".


-- 
Matthew Miller           mattdm@mattdm.org        <http://www.mattdm.org/>
Boston University Linux      ------>                <http://linux.bu.edu/>
