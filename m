Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVA0JOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVA0JOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 04:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVA0JOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 04:14:19 -0500
Received: from holomorphy.com ([66.93.40.71]:12234 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262486AbVA0JOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 04:14:16 -0500
Date: Thu, 27 Jan 2005 01:14:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050127091413.GY10843@holomorphy.com>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050127061857.GX10843@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127061857.GX10843@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
>> - Lots of updates and fixes all over the place.
>> - On my test box there is no flashing cursor on the vga console.  Known bug,
>>   please don't report it.
>>   Binary searching shows that the bug was introduced by
>>   cleanup-vc-array-access.patch but that patch is, unfortunately, huge.

On Wed, Jan 26, 2005 at 10:18:57PM -0800, William Lee Irwin III wrote:
> autofs has exploded far, far beyond complete nonfunctionality, where
> in prior 2.6.x it was not quite so blatantly a doorstop preventing all
> logins on the machine, and, in fact, multiuser mode altogether.
> Whoever's responsible, prepare to be flamed to a crisp the likes of
> which has never been witnessed before by observers of solar probes, nor
> conceived of by the most visionary and imaginative of eschatologists.

Looks like I just need to smack the hands of whoever blew away modutils.
I worked around this properly, by fully demodularizing the kernel.
Anyway, thus far ppc64 comes up clean with no patches, ia64 comes up
clean with clameter's mmtimer patch. Other arches pending.


-- wli
