Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWGKL2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWGKL2s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWGKL2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:28:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3815 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751063AbWGKL2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:28:47 -0400
Date: Tue, 11 Jul 2006 12:28:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@sgi.com>, Chris Sturtivant <csturtiv@sgi.com>,
       Paul Jackson <pj@sgi.com>, Balbir Singh <balbir@in.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [Patch 0/6] delay accounting & taskstats fixes
Message-ID: <20060711112835.GA22832@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Shailabh Nagar <nagar@watson.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, Jay Lan <jlan@sgi.com>,
	Chris Sturtivant <csturtiv@sgi.com>, Paul Jackson <pj@sgi.com>,
	Balbir Singh <balbir@in.ibm.com>,
	Chandra Seetharaman <sekharan@us.ibm.com>
References: <1152591838.14142.114.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152591838.14142.114.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 12:23:58AM -0400, Shailabh Nagar wrote:
> Andrew,
> 
> Chandra, Balbir & I have been putting taskstats and delay accounting
> patches through some extensive testing on multiple platforms.
> 
> Following are a set of patches that fix some bugs found as well as
> some cleanups of the code. Some results showing the cpumask feature 
> works as expected will follow separately.

Btw, did you ever explain what this delay accounting code is useful for
exactly?  It's an awfull lot of code that doesn't seem to have a huge
use.  While we're at it do you have a pointer to the associated userspace code?

