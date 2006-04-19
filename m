Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWDSRJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWDSRJK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWDSRJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:09:09 -0400
Received: from silver.veritas.com ([143.127.12.111]:38449 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751104AbWDSRJD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:09:03 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="37359003:sNHT24667080"
Date: Wed, 19 Apr 2006 18:08:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Arkadiusz Miskiewicz <arekm@maven.pl>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
In-Reply-To: <200604191856.16026.arekm@maven.pl>
Message-ID: <Pine.LNX.4.64.0604191803020.11787@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
 <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com>
 <200604191856.16026.arekm@maven.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Apr 2006 17:09:03.0062 (UTC) FILETIME=[F541D760:01C663D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, Arkadiusz Miskiewicz wrote:
> On Wednesday 19 April 2006 18:13, Hugh Dickins wrote:
> >
> > I was delighted to see the MSI suspend/resume fix go into 2.6.17-rc2,
> > but then disappointed. 
> 
> Are you using ahci or ata_piix? It seem that people have success with AHCI
> but not with ata_piix. 

I'm using ata_piix.  But I may have misled you.  I didn't mean to imply
any deficiency in the MSI suspend/resume fix: it's just that it sounded
like the answer to whatever my problem was, and probably is a good part
of the answer, but it now looks like I had more than one problem.

> My ThinkPad Z60m has
> 00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 
> 03)
> which afaik is AHCI capable but only if BIOS initializes it in ahci mode ;-/
> Unfortunately there is no such option in BIOS (I've checked latest available 
> bios - 1.14).
> 
> Is it possible to initialize this controller in AHCI mode by Linux itself 
> without BIOS help? (where possible means ,,possible but not implemented'', 
> too)

Someone else will have to answer that one: sorry, I've no idea.

Hugh
