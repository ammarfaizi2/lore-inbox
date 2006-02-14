Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbWBNTHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWBNTHk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWBNTHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:07:39 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:17729 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422659AbWBNTHj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:07:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q4UOYIAE44vGRHZHjglT1oEKrZy46b0KUAQhn5gzi3kDke8jbrLNajQOMwqo2wp+mmg+7HPTfdrh5JPU7B8+xxAQeCgAWizbgfA0m7/ZWrIk+OZx47AfVdphctXrw+9yp9JpOVWOXFOojCN6o/z1br4aAnExVkclWqSHyq96ca0=
Message-ID: <f383264b0602141107v78864d7bua38fbaeefafd5@mail.gmail.com>
Date: Tue, 14 Feb 2006 11:07:38 -0800
From: Matt Reimer <mattjreimer@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/8] block: convert IDE to use blk_kmap helpers
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1137165856390-git-send-email-htejun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11371658562541-git-send-email-htejun@gmail.com>
	 <1137165856390-git-send-email-htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, Tejun Heo <htejun@gmail.com> wrote:
> Convert direct uses of kmap/unmap to blk_kmap/unmap in IDE.  This
> combined with the previous bio helper change fixes PIO cache coherency
> bugs on architectures with aliased caches.
>
> Signed-off-by: Tejun Heo <htejun@gmail.com>

This series of patches makes booting from CF on my PXA255 device. Thanks Tejun.

Will these patches make 2.6.16?

Matt
