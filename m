Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUAWOid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 09:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266568AbUAWOid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 09:38:33 -0500
Received: from ns1.s2io.com ([216.209.86.101]:54410 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S266566AbUAWOic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 09:38:32 -0500
From: "Leonid Grossman" <leonid.grossman@s2io.com>
To: "'Jes Sorensen'" <jes@wildopensource.com>
Cc: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'ravinandan arakali'" <ravinandan.arakali@s2io.com>
Subject: RE: pci_alloc_consistent()
Date: Fri, 23 Jan 2004 06:37:47 -0800
Message-ID: <000001c3e1be$79904640$0400a8c0@S2IOtech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
In-Reply-To: <yq07jzj2gmx.fsf@wildopensource.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Spam-Score: -106.2
X-Spam-Outlook-Score: ()
X-Spam-Features: BAYES_01,IN_REP_TO,QUOTED_EMAIL_TEXT,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jes,

> Leonid,
> 
> What type of Itanium box? It's possible what you're seeing is 
> caused by a bug in the IOMMU code, but we would need to know 
> which one (HP, SGI or someone else's).

The problem with pci_alloc_consistent()above 1MB happens on HP rx2600
(this is 2U dual-Itanium 900MHz pci-x 133 box). I don't believe it
happens on 64 bit Opterons. Today we are going to test Dell and SGI
Itanium systems, as well as a bit newer rx 2600 with Itanium-2 1.5GHz -
I'll let you know by the end of the day.

Thanks, Leonid


> 
> Cheers,
> Jes
> 

