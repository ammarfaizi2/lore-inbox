Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269291AbTGVUto (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 16:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269736AbTGVUto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 16:49:44 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:56194 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S269291AbTGVUtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 16:49:42 -0400
Date: Tue, 22 Jul 2003 22:04:01 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ON TOPIC] HELP:  Getting lousy memory throughput from Abit KD7
Message-ID: <20030722210401.GA6952@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Timothy Miller <miller@techsource.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3F1711B5.9020800@techsource.com> <3F1D8EAB.6020801@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F1D8EAB.6020801@techsource.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 03:21:15PM -0400, Timothy Miller wrote:
 > This suggests to me that there is one of these possibilities which is 
 > contributing to the poor performance under Linux:
 > 
 > 1) Linux is not programming the KT400 chipset properly and is thus not 
 > getting the throughput it could.

Linux doesn't do any chipset specific tuning.
 
 > 2) SANDRA uses instructions (SSE, etc) which are able to access memory 
 > more efficiently than whatever STREAM is using.

very likely. its the only way to really saturate the bus.

 > 3) SANDRA inflates its scores to make people feel better.

unlikely.

 > 4) Linux has not properly set up the CPU caches.

Linux doesn't do anything with CPU caches.

 > What I want to know is this:
 > Am I getting realistic throughput for what STREAM does?

I'm unfamiliar with STREAM, so cannot comment

 > What is SANDRA doing that lets it get such high scores when STREAM does not?

Is this even an apples to apples comparison? If not, it's irrelevant.

		Dave

