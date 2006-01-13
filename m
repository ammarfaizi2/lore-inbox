Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422706AbWAMPAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422706AbWAMPAd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422708AbWAMPAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:00:33 -0500
Received: from host27-37.discord.birch.net ([65.16.27.37]:36704 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1422706AbWAMPAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:00:32 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Lee Revell'" <rlrevell@joe-job.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Dual core Athlons and unsynced TSCs
Date: Fri, 13 Jan 2006 09:10:36 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYXxZRC9OaNBs5sT0insUgU6cqR2wAjb+3w
In-Reply-To: <1137104260.2370.85.camel@mindpipe>
Message-ID: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 13 Jan 2006 14:54:07.0724 (UTC) FILETIME=[34674AC0:01C61851]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Lee Revell
> Sent: Thursday, January 12, 2006 4:18 PM
> To: linux-kernel
> Subject: Dual core Athlons and unsynced TSCs
> 
> It's been known for quite some time that the TSCs are not 
> synced between cores on Athlon X2 machines and this screws up 
> the kernel's timekeeping, as it still uses the TSC as the 
> default time source on these machines.
> 
> This problem still seems to be present in the latest kernels. 
>  What is the plan to fix it?  Is the fix simply to make the 
> kernel use the ACPI PM timer by default on Athlon X2?


Do we know if this also affects dual-core opterons?

The symptoms are that the clocks run at 2x the speed, correct?

                               Roger

