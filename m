Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbUJWSNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUJWSNm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 14:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbUJWSNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 14:13:41 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:544 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261264AbUJWSNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 14:13:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=J8Of2AOgVsXvHkAPYoAgmVaCetDxXRtkbXxM03iqbYJawoZk7KzGYdiIr0GrHj2p7dVWynStCpHMkdfndfOVRapQJqJEbvt1s41R/gZtNRHTIda4hgiXv32AAu7cdy3y1p8s3TS6A8gPrdj6vgPBA3s7HzBj9cEd0XypnNSqXHY=
Message-ID: <9e473391041023111316cbb181@mail.gmail.com>
Date: Sat, 23 Oct 2004 14:13:25 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e99704102307287a08247@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e473391041022214570eab48a@mail.gmail.com>
	 <20041023095644.GC30137@infradead.org>
	 <21d7e99704102307287a08247@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2004 00:28:18 +1000, Dave Airlie <airlied@gmail.com> wrote:
> What about this patch?
> 
> The 2.6 kernel module stuff should sort out the dependencies itself, I
> haven't had a chance to test this yet....

I made the same changes locally as new_drm_agp.patch. It works with
both AGP compiled in and not in.

-- 
Jon Smirl
jonsmirl@gmail.com
