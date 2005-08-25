Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVHYP4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVHYP4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 11:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVHYP4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 11:56:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:41171 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932204AbVHYP4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 11:56:17 -0400
From: Andi Kleen <ak@suse.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: process creation time increases linearly with shmem
Date: Thu, 25 Aug 2005 17:56:07 +0200
User-Agent: KMail/1.8
Cc: Ray Fucillo <fucillo@intersystems.com>, linux-kernel@vger.kernel.org
References: <082520051405.5272.430DD0420003F49F00001498220076139400009A9B9CD3040A029D0A05@comcast.net> <200508251622.08456.ak@suse.de> <1124981240.3055.5.camel@localhost.localdomain>
In-Reply-To: <1124981240.3055.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508251756.07849.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 August 2005 16:47, Parag Warudkar wrote:

> Exactly - one problem is that this forces all of the hugetlb users to go
> the lazy faulting way. 
Actually I disabled it for hugetlbfs (... !is_huge...vma). The reason 
is that lazy faulting for huge pages is still not in mainline.

-Andi
