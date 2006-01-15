Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751881AbWAOJgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbWAOJgI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 04:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbWAOJgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 04:36:08 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:31804 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751881AbWAOJgH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 04:36:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cnxR4MuWqzVCGKQ787Bp1QHrR1E/z5mJ0ASH960as8IHKS5mKEU7RS6V2gAG+8THFtjfT+F4CY+MSewlyRG5nKo3lVsfrCdt7a+hWiEWdmrYYku9YQm6T5yVXhV22Ws5TnTeqaZoghohMsfWpxKQRCgVTxSYavFfRmyZa00PEbo=
Message-ID: <21d7e9970601150136m25ef428es139a641e2619997@mail.gmail.com>
Date: Sun, 15 Jan 2006 20:36:05 +1100
From: Dave Airlie <airlied@gmail.com>
To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git breaks Xorg on em64t
In-Reply-To: <20060115070658.GB6454@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060114065235.GA4539@redhat.com> <200601141943.28027.ak@suse.de>
	 <20060114225137.GB23021@redhat.com> <200601150105.08197.ak@suse.de>
	 <20060115070658.GB6454@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Another datapoint btw: I've another EM64T that works just fine.
> The one that fails is the only one that isn't using onboard VGA,
> this one has a PCIE Radeon.  Given it happens when X is starting up,
> it could be that the X radeon driver does something special which
> is why others aren't seeing this.
>

It might be due to the DRM update that went through, but I can't think
what might have caused it, if you backout the DRM merge does it help
any?

did the previous kernel have DRM support for that card?

Dave.
