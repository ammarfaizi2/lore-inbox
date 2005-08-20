Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVHTVyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVHTVyv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 17:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVHTVyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 17:54:51 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:44643 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751249AbVHTVyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 17:54:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=aHaTeKt4sFFCZpaId+ow+SXrbI36b/2NNiQ9ZGbxFIk0VAC26WP8jmCla3gAYMWsjUErqYiwzyR1+TeLl6L7+ZgRe/rd3qcM2XJ/HM4oaxvLahHUodtbzy83BWdlL9Fdqi5UK4Dj2p3UuvCp57hga+CyhZewiNzLCAkdRd/U4Gk=
Date: Sat, 20 Aug 2005 17:54:35 -0400
To: Hiroyuki Machida <machida@sm.sony.co.jp>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Posix file attribute support on VFAT (take #2)
Message-ID: <20050820215435.GC13127@nineveh.rivenstone.net>
Mail-Followup-To: Hiroyuki Machida <machida@sm.sony.co.jp>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <43023957.1020909@sm.sony.co.jp> <20050816212531.GA2479@infradead.org> <43046867.4030707@sm.sony.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43046867.4030707@sm.sony.co.jp>
User-Agent: Mutt/1.5.6+20040907i
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 07:52:23PM +0900, Hiroyuki Machida wrote:
> Christoph Hellwig wrote:
> >On Wed, Aug 17, 2005 at 04:07:03AM +0900, Machida, Hiroyuki wrote:

> >>This is a take 2 of posix file attribute support on VFAT.
> >
> >
> >Sorry, but this is far too scary.  Please just use one of the sane
> >filesystems linux supports.
> >
>
> I would say that purpose of the feature is having ability to
> build root fs for small embedded device, not support full posix 
> attributes top of VFAT. I think the situation is like uclinux, 
> which has no MMU support and many restriction, however it's still
> very helpful for small embedded device.

    This doesn't seem so different from umsdos to me -- which was only
removed from the kernel because it was unmaintained.  It might have
its place.

    However, I'd guess you'd need to demonstrate that someone is
actually going to use and maintain this feature before it would be
considered for inclusion in the kernel.

--
Joseph Fannin
jfannin@gmail.com

"Bull in pure form is rare; there is usually some contamination by data."
    -- William Graves Perry Jr.
