Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVBRQY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVBRQY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 11:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVBRQY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 11:24:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:46228 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261285AbVBRQYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 11:24:16 -0500
Date: Fri, 18 Feb 2005 08:22:20 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: raybry@sgi.com, ak@suse.de, ak@muc.de, raybry@austin.rr.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
Message-Id: <20050218082220.579a5b09.pj@sgi.com>
In-Reply-To: <20050218130232.GB13953@wotan.suse.de>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	<m1vf8yf2nu.fsf@muc.de>
	<42114279.5070202@sgi.com>
	<20050215121404.GB25815@muc.de>
	<421241A2.8040407@sgi.com>
	<20050215214831.GC7345@wotan.suse.de>
	<4212C1A9.1050903@sgi.com>
	<20050217235437.GA31591@wotan.suse.de>
	<4215A992.80400@sgi.com>
	<20050218130232.GB13953@wotan.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> e.g. job runs threads on nodes 0,1,2,3  and you want it to move
> to nodes 4,5,6,7 with all memory staying staying in the same
> distance from the new CPUs as it were from the old CPUs, right? 
> 
> It explains why you want old_node, you would do 
> (assuming node mask arguments) 

Yup - my immediately preceeding post repeated this - sorry.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
