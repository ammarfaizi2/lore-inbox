Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVHCW7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVHCW7R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 18:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVHCW5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 18:57:00 -0400
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:42162 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261622AbVHCW4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 18:56:46 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jim MacBaine <jmacbaine@gmail.com>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Date: Thu, 4 Aug 2005 08:52:10 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
References: <200508031559.24704.kernel@kolivas.org> <200508040716.24346.kernel@kolivas.org> <3afbacad050803152226016790@mail.gmail.com>
In-Reply-To: <3afbacad050803152226016790@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508040852.10224.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005 08:22 am, Jim MacBaine wrote:
> On 8/3/05, Con Kolivas <kernel@kolivas.org> wrote:
> > What happens when you disable it at runtime before suspending?
> >
> > echo 0 > /sys/devices/system/dyn_tick/dyn_tick0/enable
>
> This has no effect. The system stalls at exactly the same point. The
> last lines on my screen are:

Ok perhaps on the resume side instead. When trying to resume can you try 
booting with 'dyntick=disable'. Note this isn't meant to be a long term fix 
but once we figure out where the problem is we should be able to code around 
it.

Cheers,
Con
