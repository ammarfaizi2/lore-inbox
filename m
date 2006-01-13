Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161619AbWAMAjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161619AbWAMAjD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161620AbWAMAjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:39:01 -0500
Received: from HELIOUS.MIT.EDU ([18.248.3.87]:5811 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S1161619AbWAMAjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:39:01 -0500
Date: Thu, 12 Jan 2006 19:42:36 -0500
From: Adam Belay <ambx1@neo.rr.com>
To: Dave Jones <davej@redhat.com>, Con Kolivas <kernel@kolivas.org>,
       ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-ck1
Message-ID: <20060113004236.GB11601@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Dave Jones <davej@redhat.com>, Con Kolivas <kernel@kolivas.org>,
	ck list <ck@vds.kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <20060104190554.GG10592@redhat.com> <20060112221133.GA11601@neo.rr.com> <20060112230315.GO19827@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112230315.GO19827@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 06:03:15PM -0500, Dave Jones wrote:
> On Thu, Jan 12, 2006 at 05:11:33PM -0500, Adam Belay wrote:
>  > It might be possible to do even a little better.  Currently, I'm developing a
>  > new ACPI idle policy that tries to take advantage of the long time we may
>  > be able to spend in a C3 state.
> 
> As soon as that usb timer hits (every 250ms iirc) you'll bounce back out
> of any low-power state you may be in. It's a bit craptastic that we do
> this, even if we don't have any USB devices plugged in.
> 
> 		Dave

I agree that's annoying, but isn't 250ms not often enough to make any
significant difference as far as power management is concerned?
Generally some bus master activity will come along in a shorter time frame,
causing a jump out of C3.

Thanks,
Adam
