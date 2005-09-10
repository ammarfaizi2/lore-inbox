Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVIJNWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVIJNWJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 09:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVIJNWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 09:22:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57241 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750816AbVIJNWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 09:22:08 -0400
Date: Sat, 10 Sep 2005 14:22:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jbeulich@novell.com,
       reiser@namesys.com
Subject: Re: [1/2] Make BUILD_BUG_ON fail at compile time.
Message-ID: <20050910132202.GA877@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, jbeulich@novell.com,
	reiser@namesys.com
References: <4322CBD8.mailE1M1FX8RR@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4322CBD8.mailE1M1FX8RR@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 02:04:40PM +0200, Andi Kleen wrote:
> Make BUILD_BUG_ON fail at compile time.
> 
> Force a compiler error instead of a link error, because they
> are easier to track down. Idea stolen from code by Jan Beulich.
> 
> Cc: jbeulich@novell.com

reiser4 seems to have a duplicate version of this, Hans, can you switch
over to the common one once this is in?

