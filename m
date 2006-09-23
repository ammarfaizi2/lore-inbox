Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWIXAR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWIXAR3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 20:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWIXAR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 20:17:29 -0400
Received: from 1wt.eu ([62.212.114.60]:13075 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751069AbWIXAR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 20:17:29 -0400
Date: Sun, 24 Sep 2006 01:55:33 +0200
From: Willy Tarreau <w@1wt.eu>
To: Hugh Dickins <hugh@veritas.com>
Cc: Anatoli Antonovitch <antonovi@ati.com>,
       Tigran Aivazian <tigran@veritas.com>, Michael Chen <micche@ati.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]i386: fix overflow in vmap on an x86 system which has more than 4GB memory.
Message-ID: <20060923235533.GC24214@1wt.eu>
References: <1158334477.5219.1.camel@antonovi-desktop> <Pine.LNX.4.64.0609231759590.30885@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609231759590.30885@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh !

On Sat, Sep 23, 2006 at 06:26:26PM +0100, Hugh Dickins wrote:
> This is a 2.4 fix (not needed in 2.6): let's CC maintainer Willy Tarreau.
> 
> On Fri, 15 Sep 2006, Anatoli Antonovitch wrote:
> 
> > Description
> > (max_mapnr << PAGE_SHIFT) would overflow on an x86 system which has more
> > than 4GB memory, and hence cause vmap to fail every time.
> 
> Good point, thanks for the patch.  Sorry I'm so slow to get to it.

Don't worry, Andrew already forwarded it to me. BTW, thanks for your
review and comment, I'll finally apply yours since it's better.

Cheers,
Willy

