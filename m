Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965188AbWJYNDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965188AbWJYNDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 09:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbWJYNDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 09:03:36 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:39130 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S965188AbWJYNDg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 09:03:36 -0400
Date: Wed, 25 Oct 2006 15:03:31 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, yinghai.lu@amd.com
Subject: Re: IO_APIC broken by 45edfd1db02f818b3dc7e4743ee8585af6b78f78
Message-ID: <20061025130331.GE3277@rhun.haifa.ibm.com>
References: <4ac8254d0610250537m7ee628cbo255decde52586742@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ac8254d0610250537m7ee628cbo255decde52586742@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2006 at 02:37:57PM +0200, Tuncer Ayaz wrote:
> I've bisected the non-working'ness of HD-Audio and USB Mouse on one of
> my x86_64 boxes back to the following commit.
> 
> The machine is an HP xw4400 Core 2 Duo E6600 with the Intel 975X chipset.
> Please let me know if you need any debug info.

These two patches should fix it:

http://marc.theaimsgroup.com/?l=linux-kernel&m=116157813623508&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=116157837104613&w=2

Cheers,
Muli

