Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752993AbWKCC52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbWKCC52 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 21:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752996AbWKCC52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 21:57:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32653 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752985AbWKCC51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 21:57:27 -0500
Date: Thu, 2 Nov 2006 21:56:23 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, Christian <christiand59@web.de>
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Message-ID: <20061103025623.GB8816@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org, Christian <christiand59@web.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061103024132.GG13381@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061103024132.GG13381@stusta.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 03:41:32AM +0100, Adrian Bunk wrote:
 > This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
 > that are not yet fixed in Linus' tree.
 > 
 > If you find your name in the Cc header, you are either submitter of one
 > of the bugs, maintainer of an affectected subsystem or driver, a patch
 > of you caused a breakage or I'm considering you in any other way possibly
 > involved with one or more of these issues.
 > 
 > Due to the huge amount of recipients, please trim the Cc when answering.
 > 
 > Subject    : cpufreq not working on AMD K8
 > References : http://lkml.org/lkml/2006/10/10/114
 > Submitter  : Christian <christiand59@web.de>
 > Status     : unknown

As Mark mentioned in his followup, powernow-k8 didn't change in .19 at all.
I'm suspecting an ACPI change meant that we no longer find the PST tables
correctly.

Christian, can you post the full dmesg's from the working/broken kernels.
It may be useful to enable CONFIG_ACPI_DEBUG too.

	Dave

-- 
http://www.codemonkey.org.uk
