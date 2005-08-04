Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVHDFf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVHDFf0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 01:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVHDFfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 01:35:23 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:5567 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261829AbVHDFen convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 01:34:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a1UvMmRvIBz3fS9sqvNlQvY+l8m4SLQXtShW6IUoB6o2ocRZc3gWwBg2SL0W7O7HH/DJpb9mF2H1YOLqZPSwpjvhQS/GQYYSKz1ehG3PrErNH5zlZUXSaivybp0RluZTzt0tUAjrvXDfUu/1H3vEnjbjEcBbeM/09Q6bG5La6lo=
Message-ID: <3afbacad0508032234f9af1f3@mail.gmail.com>
Date: Thu, 4 Aug 2005 07:34:42 +0200
From: Jim MacBaine <jmacbaine@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
In-Reply-To: <200508040852.10224.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508031559.24704.kernel@kolivas.org>
	 <200508040716.24346.kernel@kolivas.org>
	 <3afbacad050803152226016790@mail.gmail.com>
	 <200508040852.10224.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/05, Con Kolivas <kernel@kolivas.org> wrote:

> Ok perhaps on the resume side instead. When trying to resume can you try
> booting with 'dyntick=disable'. Note this isn't meant to be a long term fix
> but once we figure out where the problem is we should be able to code around
> it.

Sorry, no luck. 

I tried dyntick=disable and dyntick=noapic on resume time.  I also
tried suspend and resume after the system has been started with
dyntick=noapic: Same result.

As soon as I tell swsusp2 to discard its image, the system will come
up flawlessly.

Regards,
Jim
