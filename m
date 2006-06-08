Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWFHKUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWFHKUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 06:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWFHKUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 06:20:22 -0400
Received: from mx1.suse.de ([195.135.220.2]:27026 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932105AbWFHKUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 06:20:22 -0400
From: Andi Kleen <ak@suse.de>
To: bidulock@openss7.org
Subject: Re: [PATCH] use unlikely() for current_kernel_time() loop
Date: Thu, 8 Jun 2006 12:20:04 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
References: <20060607173642.GA6378@schatzie.adilger.int> <200606081114.09390.ak@suse.de> <20060608033633.A16099@openss7.org>
In-Reply-To: <20060608033633.A16099@openss7.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606081220.04060.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 11:36, Brian F. G. Bidulock wrote:
> Andi,
> 
> On Thu, 08 Jun 2006, Andi Kleen wrote:
> > 
> > > performance increased 2% per hyperthread; 
> > 
> > That would surprise me. Most likely you made some measurement error.
> > 
> 
> Don't think there was an error.  Tests performed on STREAMS external
> modules optimized with profiling data.


You mean with compiler profile feedback? 

If that is slower then it would sound like a compiler bug.

-Andi
