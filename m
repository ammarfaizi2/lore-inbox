Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbVGNEX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVGNEX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 00:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVGNEX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 00:23:56 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:25570 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262896AbVGNEXz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 00:23:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p0knM8eP+loqGwXdO+vVhGEvAN0DIVys7sEAweD+iijVge4sr6EeclG3eiLBNZCwM39sAWVbf0CeacBXqoFw4rEeP4G8QWn+QsSHJTGgNvYY47AJF0fIiHPZnl+uyzhZ3the+B516OWPE6aOp3pvxDt9O2tlRhgAc9MUj/d0rEY=
Message-ID: <9e47339105071321224adff661@mail.gmail.com>
Date: Thu, 14 Jul 2005 00:22:59 -0400
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

There is also include/linux/video

The duplicate defines need to get cleaned out of xf86drm.h or this is
going to get real confusing.

-- 
Jon Smirl
jonsmirl@gmail.com
