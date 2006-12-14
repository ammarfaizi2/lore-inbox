Return-Path: <linux-kernel-owner+w=401wt.eu-S932168AbWLNJZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWLNJZr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 04:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWLNJZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 04:25:46 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:7311 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbWLNJZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 04:25:45 -0500
Date: Thu, 14 Dec 2006 11:24:31 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Cc: andersen@codepoet.org, Karsten Weiss <K.Weiss@science-computing.de>,
       linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Message-ID: <20061214092431.GD6674@rhun.haifa.ibm.com>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <20061213202925.GA3909@codepoet.org> <45808DC3.2010907@scientia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45808DC3.2010907@scientia.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 12:33:23AM +0100, Christoph Anton Mitterer wrote:

> 4)
> And does someone know if the nforce/opteron iommu requires IBM Calgary
> IOMMU support?

It doesn't, Calgary isn't found in machine with Opteron CPUs or NForce
chipsets (AFAIK). However, compiling Calgary in should make no
difference, as we detect in run-time which IOMMU is found and the
machine.

Cheers,
Muli
