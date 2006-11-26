Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967331AbWKZIQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967331AbWKZIQl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 03:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967332AbWKZIQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 03:16:41 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:22682
	"EHLO saville.com") by vger.kernel.org with ESMTP id S967331AbWKZIQk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 03:16:40 -0500
Message-ID: <45694D6F.60100@saville.com>
Date: Sun, 26 Nov 2006 00:16:47 -0800
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
References: <fa./NRPJg+JjfSQLUVwnX1GpHGIojQ@ifi.uio.no> <fa.Y0RKABHd+7qnbGQYBAGPvlJ0Qic@ifi.uio.no> <fa.fD3WSpNqEJ4736vYzEak5Gf3xTw@ifi.uio.no> <fa.A+gkQAO1DLThaxJxPLPl3yE1CGo@ifi.uio.no> <fa.INurNKWdUKAEULTHyfpSW65a/Ng@ifi.uio.no> <fa.n9vySiI9RS2MCl0DZPDzxZEPiFw@ifi.uio.no> <4569404E.20402@shaw.ca>
In-Reply-To: <4569404E.20402@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
>>>> Actually, we need to ask the CPU/System makers to provide a system wide
> Generally user mode code should just be using gettimeofday. When the TSC 
> is usable as a sane time source, the kernel will use it. When it's not, 
> it will use something else like the HPET, ACPI PM Timer or (at last 
> resort) the PIT, in increasing degrees of slowness.
> 

But gettimeofday is much too expensive compared to RDTSC.

Wink

