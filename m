Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbTAJPy5>; Fri, 10 Jan 2003 10:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbTAJPy5>; Fri, 10 Jan 2003 10:54:57 -0500
Received: from holomorphy.com ([66.224.33.161]:13210 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265201AbTAJPy5>;
	Fri, 10 Jan 2003 10:54:57 -0500
Date: Fri, 10 Jan 2003 08:03:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, daniel.ritz@alcatel.ch,
       Robert Love <rml@tech9.net>
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup
Message-ID: <20030110160334.GU23814@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Daniel Ritz <daniel.ritz@gmx.ch>,
	linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
	daniel.ritz@alcatel.ch, Robert Love <rml@tech9.net>
References: <1042192419.1415.49.camel@cast2.alcatel.ch> <Pine.LNX.4.44.0301101428420.1292-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301101428420.1292-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 03:29:19PM +0000, Hugh Dickins wrote:
> I hope I can leave this discussion to others: I just wanted to get
> my symbols printing out right, and noticed the current stem compression
> unnecessarily weak there; but I'm no expert on suitable algorithms.

I can help some here but probably no more than you (in fact, you've
spotted far more [> 0] issues with the current code than I).


Basically, if you want fast string lookup of compressed stuff I can sit
down with whiteboard etc. and fiddle around, but it sounds like from f's
comments that this isn't really wanted.

So the end-result of the discussion is, "What should really happen here?"
and "What, if anything, do you want me to do?"


Bill
