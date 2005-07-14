Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262887AbVGNE0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbVGNE0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 00:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVGNE0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 00:26:50 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:19979 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262887AbVGNE0r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 00:26:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RU8r73IfbYNhLUoRamFdDU6w+t/15F45Pl8GKWKeNUYZnvhECVxLNxFGGsCRsHkTadqO3B3E9e/2dIUIV2JumIS8ak26N5/zXzDoj28dVHVSXzRtiTiou8+kJATTrXpgXV/KKFGrr2RzleFHMYQQLghRPj5OwK8JjkfFMJ8F5xM=
Message-ID: <9e4733910507132125af9835@mail.gmail.com>
Date: Thu, 14 Jul 2005 00:25:45 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: moving DRM header files
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e99705071321044c216db4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <21d7e99705071321044c216db4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/05, Dave Airlie <airlied@gmail.com> wrote:
> Hi,
> I'd like to move the interface DRM header files (drm.h and *_drm.h)
> somewhere more useful and also more "user-space" visible, (i.e. so
> kernel-headers could start picking them up.)
> 
> I'm thinking include/linux/drm/
> but include/linux would also be possible.
> 
> Any suggestions or ideas?

If you're in a mood to move things, how about moving drivers/char/drm
to drivers/video/drm.

-- 
Jon Smirl
jonsmirl@gmail.com
