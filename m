Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSHMIQy>; Tue, 13 Aug 2002 04:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSHMIQx>; Tue, 13 Aug 2002 04:16:53 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:19465 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314277AbSHMIQx>; Tue, 13 Aug 2002 04:16:53 -0400
Date: Tue, 13 Aug 2002 09:20:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] __func__ -> __FUNCTION__
Message-ID: <20020813092043.A1859@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D58A45F.A7F5BDD@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D58A45F.A7F5BDD@zip.com.au>; from akpm@zip.com.au on Mon, Aug 12, 2002 at 11:17:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 11:17:03PM -0700, Andrew Morton wrote:
> 
> It is a requirement of the SPARC port that Linux be compilable
> by egcs-1.1.2, aka gcc-2.91.66.
> 
> That compiler does not support __func__.

Is there any reason to not use __FUNCTION__?  According to the gcc folks
that there is no plan to retire it, and as long as all known-good kernel
compilers support it a gccism is a lot better than a standard feature that
is not supported by most of the kernel compilers.

