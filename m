Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWDBIBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWDBIBT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 04:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWDBIBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 04:01:19 -0400
Received: from mtaout3.012.net.il ([84.95.2.7]:33334 "EHLO mtaout3.012.net.il")
	by vger.kernel.org with ESMTP id S932076AbWDBIBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 04:01:19 -0400
Date: Sun, 02 Apr 2006 11:00:35 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
In-reply-to: <442F827E.8040104@archive.org>
To: Joerg Bashir <brak@archive.org>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>, ak@suse.de,
       jgarzik@pobox.com
Message-id: <20060402080035.GA7856@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <5Mq18-1Na-21@gated-at.bofh.it> <5MqNc-2Y5-3@gated-at.bofh.it>
 <5MqX4-39H-21@gated-at.bofh.it> <5MyAS-5zh-5@gated-at.bofh.it>
 <440CD09A.9040005@shaw.ca> <442F827E.8040104@archive.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2006 at 11:51:26PM -0800, Joerg Bashir wrote:

> I saw a lot of patches come through by Muli but am not sure they address
> this issue, do they?

No, I'm afraid not - our patches are to support a different
IOMMU, and it looks like this problem is gart specific. I'll go dig
through the archive, but is there consensus on how to solve this bug
and it's just a question of doing the work, or is the root cause
unknown?

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

