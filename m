Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVBKLWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVBKLWb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 06:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVBKLWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 06:22:31 -0500
Received: from sd291.sivit.org ([194.146.225.122]:5283 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262092AbVBKLW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 06:22:29 -0500
Date: Fri, 11 Feb 2005 12:24:08 +0100
From: Stelian Pop <stelian@popies.net>
To: "Daniel K." <dk@cluded.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/5] sonypi: add another HELP button event
Message-ID: <20050211112408.GH3263@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	"Daniel K." <dk@cluded.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20050210154542.GG3493@crusoe.alcove-fr> <420B9A59.3040807@cluded.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420B9A59.3040807@cluded.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2005 at 05:31:05PM +0000, Daniel K. wrote:

> >  	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_HELP_MASK, sonypi_helpev },
> > +	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_HELP_MASK, sonypi_helpev },
> 
> I suspect you should simply replace the '0x08' line as it was left over
> from my earlier patch introducing EVTYPE_OFFSET. At that time all the
> values were 0x08, most was updated, but a few were not, due to
> unsuficcient data.

I think you're right. I've queued this for a later update. 

Thanks.

Stelian.
-- 
Stelian Pop <stelian@popies.net>
