Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVEQIH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVEQIH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 04:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVEQIH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 04:07:27 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:37055 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261361AbVEQIHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 04:07:13 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: davidm@hpl.hp.com
Date: Tue, 17 May 2005 10:05:08 +0200
MIME-Version: 1.0
Subject: Re: IA64 implementation of timesource for new time of day subsystem
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, linux-ia64@vger.kernel.org
Message-ID: <4289C1D4.5666.6DBB9A@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <17032.62615.750699.18847@napali.hpl.hp.com>
References: <Pine.LNX.4.62.0505161219570.2158@schroedinger.engr.sgi.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.26/Sophos-P=3.92.0+V=3.92+U=2.07.092+R=04 April 2005+T=103334@20050517.075159Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 May 2005 at 12:29, David Mosberger wrote:

> >>>>> On Mon, 16 May 2005 12:24:08 -0700 (PDT), Christoph Lameter <clameter@engr.sgi.com> said:
> 
>   Christoph> Other IA64 vendors will see that their timer performance
>   Christoph> drops significantly after the new timer subsystem is
>   Christoph> in. IBM no longer has IA64 systems that rely on ITC?
> 
> Would that somehow make it ok to break existing and working code?

AFAIR the design goal was not to make a new time implementation, but to make a 
more precise one ;-)

Regards,
Ulrich

