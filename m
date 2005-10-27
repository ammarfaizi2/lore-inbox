Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVJ0Qxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVJ0Qxt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 12:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVJ0Qxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 12:53:49 -0400
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:61189 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1751289AbVJ0Qxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 12:53:48 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: <sander@humilis.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: EDAC (was: Re: 2.6.14-rc5-mm1)
Date: Thu, 27 Oct 2005 11:59:59 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcXavkz5OQ4ZqfS+SiaEMumeEx7+vwAWNKaA
In-Reply-To: <20051027062312.GB15552@favonius>
Message-ID: <EXCHG2003ifWoqFXfyY0000032a@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 27 Oct 2005 16:49:04.0228 (UTC) FILETIME=[56D1CA40:01C5DB16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> Ok :-)  But you also say more investigation is needed. Is 
> this something I can help with, as an owner of this hardware?

You might try something like HPL or some other benchmark that validates
its results, I have found that if you have PCI parity errors, even
potentially
on cards that the benchmark should not be using, it will usually cause 
invalid results in the benchmark when it is ran over several days.

This is even worse if the benchmark is using an interconnect board with
a lot of its communication going across the board.

> 
> And is there an EDAC list which reports should go to or is lkml fine?
> There is no MAINTAINERS entry or info in Documentation (in 
> 2.6.14-rc4-mm1).
> 
 
Lists.sourceforge.net

Search for bluesmoke, the original name.   It may be in the process
of being changed to EDAC.

               

> 
> I'd better configure EDAC :-)
> 
> Thanks for your answers Doug.


If you have ECC ram, just the ECC monitoring is important enough
even without the PCI parity stuff working.

                         Roger

