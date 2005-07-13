Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262876AbVGMPXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbVGMPXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 11:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbVGMPXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 11:23:20 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:33048 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262681AbVGMPXJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 11:23:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NlP1nWAttp+GJ65gnARsps9ON7IOM8mGwmmnTv9DRyqdAss7hRCHuYhUzvGykIzmconi7pMUDR9fwUdinJyOep3P0Lwm0aCaV/ZlD17m22VR6qN8fUau1n3EzrEccjqhTPitgEbxk1+cpD7004I7wpg6SbLPQg8VmZHxJTSnlHg=
Message-ID: <60868aed0507130822c2e9e97@mail.gmail.com>
Date: Wed, 13 Jul 2005 18:22:28 +0300
From: Yura Pakhuchiy <pakhuchiy@gmail.com>
Reply-To: Yura Pakhuchiy <pakhuchiy@gmail.com>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: XFS corruption on move from xscale to i686
Cc: linux-xfs@oss.sgi.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, tibor@altlinux.ru, pakhuchiy@gmail.com
In-Reply-To: <20050708042146.GA1679@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1120756552.5298.10.camel@pc299.sam-solutions.net>
	 <20050708042146.GA1679@frodo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/7/8, Nathan Scott <nathans@sgi.com>:
> On Thu, Jul 07, 2005 at 08:15:52PM +0300, Yura Pakhuchiy wrote:
> > Hi,
> >
> > I'm creadted XFS volume on 2.6.10 linux xscale/iq31244 box, then I
> > copyied files on it and moved this hard drive to i686 machine. When I
> > mounted it on i686, I found no files on it. I runned xfs_check, here is
> > output:
> 
> Someone else was doing this awhile back, and also had issues.
> Their trouble seemed to be related to xscale gcc miscompiling
> parts of XFS - search the linux-xfs archives for details.

I found patch by Greg Ungreger to fix this problem, but why it's still
not in mainline? Or it's a gcc problem and should be fixed by gcc folks?
BTW, my kernel on xscale is compiled using gcc 3.4.3.

Thanks,
        Yura
