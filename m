Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264254AbUFCR30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbUFCR30 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUFCR2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:28:37 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:40904 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263325AbUFCRQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:16:02 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6] ICH5 SATA problems [solved]
Date: Thu, 3 Jun 2004 19:15:56 +0200
User-Agent: KMail/1.6.2
References: <200406030642.16890.lkml@kcore.org>
In-Reply-To: <200406030642.16890.lkml@kcore.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406031915.57397.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2004 06:42, Jan De Luyck wrote:
> Hello List,
>
> A friend of mine is trying to get both SATA and PATA working together on
> his Siemens box. The bios has a bunch of settings concering sata/pata,
> being:
> - SATA Standard (which is bootable by the bios). When this is selected,
> another setting is available * Sata 1/2 only
> 	* sata 1/2 + pata 3/4
> 	* pata 1/2 + sata 1/2

I've since then contacted Siemens on this issue, they tell me that with Sata 
Standard, the bios makes up the entire IDE system of what you select: 2 sata 
ports, or 2 sata + 2 pata ports. It can't support more than 4 ports and still 
boot from it.

If you want them all, first upgrade the bios to the latest version and put it 
on "OS Only".

Both work as a charm now.

Thanks anyway ;-)

Jan
-- 
Every time I think I know where it's at, they move it.
