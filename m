Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161099AbVKDIUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbVKDIUt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 03:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbVKDIUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 03:20:49 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:42175 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161099AbVKDIUs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 03:20:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iJylGyX4PxlMQ6FTx4tGMJthmAsufAOP/hpdbwJab0JUzagKjAsJI3r3aituNCpZiOB8XeAUAGVF8OCl6tpmhqTlCrqQDL0Wd36SE3ZeikWBjw8qrwjeEtOjY0LFCv659zfJGZbvqCgFkNlZSV4eMHSu8AOROOz+WLIxCZ7tle4=
Message-ID: <84144f020511040020n7ae5a460ud9ba5bbec9317748@mail.gmail.com>
Date: Fri, 4 Nov 2005 10:20:47 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 1/2] slob: introduce mm/util.c for shared functions
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051104062455.GD4367@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2.505517440@selenic.com> <20051103211357.072c5646.akpm@osdl.org>
	 <20051104062455.GD4367@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/05, Matt Mackall <mpm@selenic.com> wrote:
> Well, yes. But I decided not to do that now because I ended up wanting
> to create mm/util.c anyway for kzalloc. I suspect we'll see other
> helper functions like kzalloc and kstrdup down the road.

I prefer this as well. kstrdup() is _not_ a string operation but a
special purpose memory allocator just like kzalloc() and kcalloc().

                               Pekka
