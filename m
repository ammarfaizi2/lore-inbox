Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUIATGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUIATGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUIATGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:06:12 -0400
Received: from holomorphy.com ([207.189.100.168]:33991 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266879AbUIATGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:06:07 -0400
Date: Wed, 1 Sep 2004 12:06:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch final : i386 tested, x86_64 support added
Message-ID: <20040901190600.GM5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Matthew Wilcox <willy@debian.org>,
	linux-kernel@vger.kernel.org
References: <20040827173641.5cfb79f6.akpm@osdl.org> <20040828010253.GA50329@muc.de> <20040827183940.33b38bc2.akpm@osdl.org> <16687.59671.869708.795999@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0408272021070.16607@schroedinger.engr.sgi.com> <20040827204241.25da512b.akpm@osdl.org> <Pine.LNX.4.58.0408272121300.16949@schroedinger.engr.sgi.com> <20040827223954.7d021aac.akpm@osdl.org> <20040901180352.GH642@parcelfarce.linux.theplanet.co.uk> <20040901111911.66e89189.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901111911.66e89189.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> wrote:
>> Sure, but the same kind of app can also do this on 32-bit architectures.
>> Assuming there's only 2.5GB of address space available per process,
>> you'd need 1638 cooperating processes to do it.  OK, that's a lot but
>> the lowest limit I can spy on a quick poll of multiuser boxes I have a
>> login on is 3064.  Most are above 10,000 (poll sample includes Debian,
>> RHAS and Fedora).

On Wed, Sep 01, 2004 at 11:19:11AM -0700, Andrew Morton wrote:
> It requires 32GB's worth of pte's.
> So yeah, it might be possible on a 64GB ia32 box.

This only requires approximately 10922.666666666666 processes, which
has surprisingly been done in practice.


-- wli
