Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSGUV22>; Sun, 21 Jul 2002 17:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSGUV22>; Sun, 21 Jul 2002 17:28:28 -0400
Received: from holomorphy.com ([66.224.33.161]:21888 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314340AbSGUV21>;
	Sun, 21 Jul 2002 17:28:27 -0400
Date: Sun, 21 Jul 2002 14:31:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] move slab pages to the lru, for 2.5.27
Message-ID: <20020721213131.GA919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Craig Kulesa <ckulesa@as.arizona.edu>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <Pine.LNX.4.44.0207210245080.6770-100000@loke.as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207210245080.6770-100000@loke.as.arizona.edu>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 04:24:55AM -0700, Craig Kulesa wrote:
> This is an update for the 2.5 port of Ed Tomlinson's patch to move slab
> pages onto the lru for page aging, atop 2.5.27 and the full rmap patch.  
> It is aimed at being a fairer, self-tuning way to target and evict slab
> pages.

In combination with the pte_chain in slab patch, this should at long last
enable reclamation of unused pte_chains after surges in demand. Can you
test this to verify that reclamation is actually done? (I'm embroiled in
a long debugging session at the moment.)


Thanks,
Bill
