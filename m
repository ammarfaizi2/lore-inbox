Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUIOHZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUIOHZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 03:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUIOHZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 03:25:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57278 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261232AbUIOHXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 03:23:30 -0400
Date: Wed, 15 Sep 2004 09:21:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Joshua Schmidlkofer <kernel@pacrimopen.com>
Cc: Con Kolivas <kernel@kolivas.org>, jch@imr-net.com,
       ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Cliff Wells <clifford.wells@comcast.net>
Subject: Re: [ck] Re: 2.6.8.1-ck7, Two Badnessess, one dump.
Message-ID: <20040915072154.GJ2304@suse.de>
References: <41412765.4010005@kolivas.org> <4144F691.6040405@pacrimopen.com> <41451957.7000101@kolivas.org> <4145BAE9.1040800@pacrimopen.com> <20040913191237.GF18883@suse.de> <4146698F.2060305@pacrimopen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4146698F.2060305@pacrimopen.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13 2004, Joshua Schmidlkofer wrote:
> >Is your drive idle while applying dma settings? Current 2.6 kernels
> >aren't even close to being safe to modify drive settings, since it makes
> >no effective attempts to serialize with ongoing commands. I have a
> >half-assed patch to fix that.
> 
> 1.  Sorry about the HTML

Didn't see any?

> 2.  How half-assed is the patch / what is it likely to break?

It's only half-assed in concept, because it doesn't cover some obscure
corner cases which you aren't affected by. It wont break. See previous
mail.

-- 
Jens Axboe

