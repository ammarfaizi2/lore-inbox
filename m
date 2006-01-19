Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161352AbWAST1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161352AbWAST1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161353AbWAST1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:27:40 -0500
Received: from fsmlabs.com ([168.103.115.128]:42383 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1161352AbWAST1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:27:39 -0500
X-ASG-Debug-ID: 1137698856-12931-39-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 19 Jan 2006 11:32:37 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Gilles May <gilles@jekyll.org>
cc: linux-kernel@vger.kernel.org
X-ASG-Orig-Subj: Re: SMP trouble
Subject: Re: SMP trouble
In-Reply-To: <43CFD877.4090503@jekyll.org>
Message-ID: <Pine.LNX.4.64.0601191132010.1579@montezuma.fsmlabs.com>
References: <43CAFF80.2020707@jekyll.org> <Pine.LNX.4.64.0601181817410.20777@montezuma.fsmlabs.com>
 <43CFD877.4090503@jekyll.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.7564
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Gilles May wrote:

> Attached the bootlog with noapic parameter passed to the kernel. It still
> freezes though. :(
> What I do exactly to make it freeze is after boot:
> 
> In one console I do a ping -f to a box on my local network using the e100
> card. (integrated on the motherboard)
> 
> In another console I copy a 2.5 GB file from my USB HDD to the IDE HDD in a
> while loop (or do a readcd from USB DVD Writer to a file on IDE HDD)

Can you try it whilst copying from say SCSI disk to IDE disk?
