Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbUCRXwp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbUCRXwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:52:10 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:26305 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP id S263317AbUCRX3k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:29:40 -0500
From: Mark <mark@harddata.com>
Organization: Hard Data Ltd
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH,RFT] latest libata (includes Silicon Image work)
Date: Thu, 18 Mar 2004 16:28:33 -0700
User-Agent: KMail/1.6
References: <4059EBB8.4010807@pobox.com>
In-Reply-To: <4059EBB8.4010807@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200403181628.33558.mark@harddata.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 18, 2004 11:34 am, Jeff Garzik <jgarzik@pobox.com> wrote:
> Attached is the latest libata patch against 2.6.x mainline.  Although
> not 100% of content, most of this patch resolves around getting Silicon
> Image into better shape.  As I mentioned in my last post, this patch
> affects all libata users, so plenty of testing is requested.
>
Jeff,

After applying this to and rebuilding arjanv newest redhat kernel 
(2.6.4-1.275), sd_mod doesn't load when at sata_sil is loaded. It did before 
I patched the kernel rpm.

-- 
Mark Lane, CET mailto:mark@harddata.com 
Hard Data Ltd. http://www.harddata.com 
T: 01-780-456-9771   F: 01-780-456-9772
11060 - 166 Avenue Edmonton, AB, Canada, T5X 1Y3
--> Ask me about our Excellent 1U Systems! <--
