Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265302AbUFSIjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265302AbUFSIjy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 04:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbUFSIjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 04:39:53 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:18437 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265302AbUFSIjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 04:39:40 -0400
Subject: Re: 2.6.7-ck1
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <40D3CD2D.5040004@kolivas.org>
References: <200406162122.51430.kernel@kolivas.org>
	 <1087576093.2057.1.camel@teapot.felipe-alfaro.com>
	 <200406191348.57383.kernel@kolivas.org>  <40D3CD2D.5040004@kolivas.org>
Content-Type: text/plain
Date: Sat, 19 Jun 2004 10:39:37 +0200
Message-Id: <1087634377.2008.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-19 at 15:20 +1000, Con Kolivas wrote:
> Con Kolivas wrote:
> >>I've found some interaction problems between, what I think it's, the
> >>staircase scheduler and swsusp. With vanilla 2.6.7, swsusp is able to
> >>save ~9000 pages to disk in less than 5 seconds, where as 2.6.7-ck1
> >>takes more than 1 minute to save the same amount of pages when
> >>suspending to disk.
> 
> You might want to try the attached patch which addresses an issue with 
> kernel threads that is going into staircase 7.1

This patch completely fixes my problems with SWSUSP.
Nice job!

