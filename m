Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWAQTGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWAQTGx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWAQTGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:06:52 -0500
Received: from holomorphy.com ([66.93.40.71]:39319 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S964783AbWAQTGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:06:51 -0500
Date: Tue, 17 Jan 2006 11:06:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Huge pages and small pages. . .
Message-ID: <20060117190650.GC13708@holomorphy.com>
References: <43CD3CE4.3090300@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CD3CE4.3090300@comcast.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 01:52:20PM -0500, John Richard Moser wrote:
> Is there anything in the kernel that shifts the physical pages for 1024
> physically allocated and contiguous virtual pages together physically
> and remaps them as one huge page?  This would probably work well for the
> low end of the heap, until someone figures out a way to tell the system
> to free intermittent pages in a big mapping (if the heap has an
> allocation up high, it can have huge, unused areas that are allocated).
>  It may possibly work for disk cache as well, albeit I can't say for
> sure if it's common to have a 4 meg contiguous section of program data
> loaded.
> Shifting odd huge allocations around would be neat to, re:
> {2m}[4M  ]{2m}  ->  [4M  ][4M  ]

I've got bugs and feature work written by others that has sat on hold
for ages to merge, so I won't be looking to experiment myself.

Do write things yourself and send in the resulting patches, though.


-- wli
