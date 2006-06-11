Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbWFKD1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWFKD1y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 23:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWFKD1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 23:27:54 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:25777 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161075AbWFKD1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 23:27:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QsTWspe28qGL3oUenG61GtiSra0xgY1+M1eBUqPH+OS0//UP9Rsr4aQ/0Izq6nDhCwxHlenOCJV8+y0t5O93M06v2TXUuGVCEBOqDW+JvguJ8OljGHLY5I3Y32vFnn0MrSrDagUR7Q7H+FHkV9HDXSd8wRZT1KQh6rh5eNGNWyQ=
Message-ID: <9e4733910606102027o8438d55webf938dfc8495ea8@mail.gmail.com>
Date: Sat, 10 Jun 2006 23:27:52 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>
In-Reply-To: <448B8818.1010303@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44893407.4020507@gmail.com> <448AC8BE.7090202@gmail.com>
	 <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
	 <448B38F8.2000402@gmail.com>
	 <9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>
	 <448B61F9.4060507@gmail.com>
	 <9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>
	 <448B6ED3.5060408@gmail.com>
	 <9e4733910606101905y6bfdff4bo3c1b1a2126d02b26@mail.gmail.com>
	 <448B8818.1010303@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> My point is: 'Multiple active drivers feature' is a natural consequence
> of the evolution of the code, but the only way to take advantage of it
> is if we provide a means for the user to use it.  And we are not
> providing the means.

I'd rather not provide the means and defer this capability to a user
space implementation where we can achieve true multi-user,
multi-adapter and multi-head support. The more features we add to the
VT layer today, the harder it will be to replace it in the future.

I'd like to keep the sysfs attributes as simple as possible because if
they get too complex and flexible no one is going to know how to set
them. But you're writing the code and you'll do what you think is
best.

-- 
Jon Smirl
jonsmirl@gmail.com
