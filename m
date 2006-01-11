Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751708AbWAKRpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbWAKRpF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbWAKRpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:45:05 -0500
Received: from ms-smtp-04.rdc-kc.rr.com ([24.94.166.116]:26084 "EHLO
	ms-smtp-04.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S1751708AbWAKRpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:45:03 -0500
Date: Wed, 11 Jan 2006 11:44:58 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH ]  VMSPLIT config options (with default config fixed)
Message-ID: <20060111174458.GA6128@yggdrasil.localdomain>
Mail-Followup-To: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3E9C2.1000309@rtr.ca> <20060110173217.GU3389@suse.de> <43C3F0CA.10205@rtr.ca> <43C403BA.1050106@pobox.com> <43C40803.2000106@rtr.ca> <20060111160050.GA5472@yggdrasil.localdomain> <43C53CA2.7070002@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C53CA2.7070002@rtr.ca>
X-Operating-System: Linux yggdrasil 2.6.15 #1 SMP PREEMPT Tue Jan 10 20:27:55 CST 2006 i686 GNU/Linux
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 12:13:06PM -0500, Mark Lord wrote:
> Greg Norris wrote:
> >Is there any benefit/point to enabling HIGHMEM when using this patch, 
> >assuming that physical memory is smaller than the address space?  For 
> >example, when using VMSPLIT_3G_OPT on a box with 1G of memory.
> 
> No.  In fact, there should be a (very) tiny performance gain
> by NOT enabling HIGHMEM -- things like kmap() should get simpler.

That's essentially what I thought, but it's nice to have some 
verification.  Thanx!
