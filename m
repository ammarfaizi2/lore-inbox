Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWFQDha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWFQDha (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 23:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbWFQDha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 23:37:30 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:35080 "EHLO
	mms1.broadcom.com") by vger.kernel.org with ESMTP id S1751586AbWFQDh3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 23:37:29 -0400
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Re: tg3 timeouts with 2.6.17-rc6
Date: Fri, 16 Jun 2006 20:37:17 -0700
Message-ID: <1551EAE59135BE47B544934E30FC4FC041BD1E@NT-IRVA-0751.brcm.ad.broadcom.com>
Thread-Topic: tg3 timeouts with 2.6.17-rc6
Thread-Index: AcaRuPL9yhruNCIyT7mNLGFD6QPqewABfL2Q
From: "Michael Chan" <mchan@broadcom.com>
To: "David Miller" <davem@davemloft.net>
cc: jk@blackdown.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006061610; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230382E34343933373736372E303030372D412D;
 ENG=IBF; TS=20060617033722; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006061610_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 688DA7650HW32705029-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:

> From: "Michael Chan" <mchan@broadcom.com>
> Date: Fri, 16 Jun 2006 18:27:32 -0700
> 
> > In the meantime, I wonder if we should disable TSO by default on the
> > 5780 chip for 2.6.17.
> 
> Sounds reasonable.  Would we disable it for all chips that set
> TG3_FLG2_5780_CLASS or a specific variant?
> 
Yes, let's disable it for all TG3_FLG2_5780_CLASS chips for now
until we figure out what's going on.

