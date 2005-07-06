Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVGFT6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVGFT6G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVGFT4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:56:39 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:36990 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261784AbVGFPuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:50:12 -0400
X-IronPort-AV: i="3.94,173,1118034000"; 
   d="scan'208"; a="262528177:sNHT18200614"
Date: Wed, 6 Jul 2005 10:57:35 -0500
From: Doug Warzecha <Douglas_Warzecha@dell.com>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: Add Dell Systems Management Base driver
Message-ID: <20050706155734.GA4271@sysman-doug.us.dell.com>
References: <20050706001333.GA3569@sysman-doug.us.dell.com> <20050706041702.GA10253@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706041702.GA10253@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 11:17:03PM -0500, Greg KH wrote:
>    > +static void dcdbas_device_release(struct device *dev)
>    > +{
>    > +     /* nothing to release */
>    > +}
> 
>    This is a symptom of a broken driver.
> 
>    Hm, I wonder if there's some way for the compiler to check the fact that
>    a function pointer passed to another function, is really a null
>    function.  That would stop this kind of nonsense...

There are other drivers in the kernel tree with null device release functions.

> 
>    I'm sure I commented on this driver already, yet, I never got a response
>    and the code is not changed.  Is there some reason for this?  That's a
>    sure way to prevent your patch from ever being applied...

This is the first comment on the release function.  The code has been changing in response to comments from you and others.  We'll continue to make changes as needed.

Doug
