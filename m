Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269488AbUHZTnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269488AbUHZTnK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269436AbUHZTjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:39:17 -0400
Received: from verein.lst.de ([213.95.11.210]:21214 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269483AbUHZTfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:35:52 -0400
Date: Thu, 26 Aug 2004 21:34:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
       torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826193436.GA8693@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Lee Revell <rlrevell@joe-job.com>, Hans Reiser <reiser@namesys.com>,
	Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>, flx@namesys.com,
	torvalds@osdl.org, reiserfs-list@namesys.com
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <412DAC59.4010508@namesys.com> <1093548414.5678.74.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093548414.5678.74.camel@krustophenia.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 03:26:55PM -0400, Lee Revell wrote:
> OK, real world example.  My roommate has an AKAI MPC-2000, a very
> popular hardware sampler from the 90's.  The disk format is known,there
> are a few utilities to edit the disks on a PC and extract the PCM
> samples, but there are no tools to mount it on a modern PC.  Are you
> saying that, since I know the MPC disk format, I could write a reiser4
> plugin to mount an MPC drive?
> 
> If so, then Hans has an excellent point.  Users do want this kind of
> thing, and it is worth having to fix tar et al.

You don't need reiser4 for that, writing read-only linux filesystems is
trivial as soon as you have a specification of the ondisk format.

