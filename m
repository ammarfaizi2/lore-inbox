Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWGTDEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWGTDEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 23:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWGTDEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 23:04:35 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:10212 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964894AbWGTDEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 23:04:35 -0400
Date: Wed, 19 Jul 2006 20:04:34 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Jeff Garzik <jeff@garzik.org>
cc: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
In-Reply-To: <44BECAA2.6010402@garzik.org>
Message-ID: <Pine.LNX.4.58.0607192003030.20069@shell3.speakeasy.net>
References: <1153341500.44be983ca1407@portal.student.luth.se>
 <44BE9E78.3010409@garzik.org> <1153351042.44bebd82356a4@portal.student.luth.se>
 <44BECAA2.6010402@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2006, Jeff Garzik wrote:

> ricknu-0@student.ltu.se wrote:
> > Citerar Jeff Garzik <jeff@garzik.org>:
> >> Also, you don't want to force 'unsigned char' on code, because often
> >> code prefers a machine integer to something smaller than a machine integer.
>
> > But isn't a bit smaller than a byte? Sorry, do not understand what you mean.
>
> For all processors, it is generally preferred to have integer operations
> performed on a "machine integer."  A machine integer is the natural data
> type of the processor.  If it's a 32-bit processor, the natural data
> type for the ALU is a 32-bit int.  If it's a 64-bit processor, the
> natural data type for the ALU is a 64-bit int.

If this is the case, then wouldn't "long" be preferable to "int"?

> 	Jeff

-- Vadim Lobanov
