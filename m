Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932983AbWFZTu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932983AbWFZTu5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932982AbWFZTu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:50:57 -0400
Received: from server99.tchmachines.com ([72.9.230.178]:28847 "EHLO
	server99.tchmachines.com") by vger.kernel.org with ESMTP
	id S932983AbWFZTu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:50:56 -0400
Date: Mon, 26 Jun 2006 12:52:20 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Paul Jackson <pj@sgi.com>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: remove __read_mostly?
Message-ID: <20060626195220.GA4323@localhost.localdomain>
References: <20060625115736.d90e1241.akpm@osdl.org> <20060625211929.GA3865@localhost.localdomain> <20060626113950.571d3e4c.pj@sgi.com> <Pine.LNX.4.64.0606261142560.32190@schroedinger.engr.sgi.com> <20060626121124.45ecc5f2.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626121124.45ecc5f2.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 12:11:24PM -0700, Paul Jackson wrote:
> Christoph wrote:
> > 99:1 may be too small a ratio.
> 
> Could well be.  I was just quoting Ravikiran's number.  I suspect he
> was using the number loosely, not as a precise value.

Yes I was using it loosely.  I also mentioned ~100% read which is probably
more accurate :).  It is indeed "read hot write cold".  Writes on these
variables are typically during bootup/subsystem initialization/hot plug
events.

Thanks,
Kiran
