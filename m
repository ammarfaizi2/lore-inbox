Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVBRQVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVBRQVx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 11:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVBRQVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 11:21:53 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:2248 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261398AbVBRQVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 11:21:44 -0500
Date: Fri, 18 Feb 2005 08:20:39 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: raybry@sgi.com, ak@suse.de, ak@muc.de, raybry@austin.rr.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
Message-Id: <20050218082039.3b1d03c1.pj@sgi.com>
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
> I don't like old_node* very much because it's imho unreliable
> (because you can usually never fully know on which nodes the old
> process was and there can be good reasons to just migrate everything)

That's one way that the arrays of old and new nodes pays off.
You can list any old node that might have a page, and state
which new node that page should go to.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
