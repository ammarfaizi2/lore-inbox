Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265276AbTAJQDa>; Fri, 10 Jan 2003 11:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTAJQD3>; Fri, 10 Jan 2003 11:03:29 -0500
Received: from ns.suse.de ([213.95.15.193]:31501 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265276AbTAJQD3>;
	Fri, 10 Jan 2003 11:03:29 -0500
Date: Fri, 10 Jan 2003 17:12:12 +0100
From: Andi Kleen <ak@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Hugh Dickins <hugh@veritas.com>, Daniel Ritz <daniel.ritz@gmx.ch>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       daniel.ritz@alcatel.ch, Robert Love <rml@tech9.net>
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup
Message-ID: <20030110161212.GA11193@wotan.suse.de>
References: <1042192419.1415.49.camel@cast2.alcatel.ch> <Pine.LNX.4.44.0301101428420.1292-100000@localhost.localdomain> <20030110160334.GU23814@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030110160334.GU23814@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So the end-result of the discussion is, "What should really happen here?"
> and "What, if anything, do you want me to do?"

IMHO best would be to get rid of /proc/*/wchan and keep the kallsyms 
lookup slow, simple and stupid.

-Andi
