Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWAPQ40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWAPQ40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWAPQ40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:56:26 -0500
Received: from ns1.suse.de ([195.135.220.2]:20429 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751117AbWAPQ4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:56:25 -0500
Date: Mon, 16 Jan 2006 17:56:18 +0100
From: Nick Piggin <npiggin@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Christoph Lameter <clameter@engr.sgi.com>,
       Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
Message-ID: <20060116165618.GB21064@wotan.suse.de>
References: <20060114155517.GA30543@wotan.suse.de> <Pine.LNX.4.62.0601160807580.19672@schroedinger.engr.sgi.com> <Pine.LNX.4.61.0601161620060.9395@goblin.wat.veritas.com> <200601161751.26991.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601161751.26991.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 05:51:26PM +0100, Andi Kleen wrote:
> 
> I agree with Christoph that the zero page should be ignored - old behaviour
> was really a bug.
> 

Fair enough. It would be nice to have a comment there has Hugh said;
it is not always clear what PageReserved is intended to test for.

Nick

