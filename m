Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932931AbWFZTLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbWFZTLw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932933AbWFZTLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:11:51 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:19931 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932931AbWFZTLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:11:51 -0400
Date: Mon, 26 Jun 2006 12:11:24 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: kiran@scalex86.org, akpm@osdl.org, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: remove __read_mostly?
Message-Id: <20060626121124.45ecc5f2.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606261142560.32190@schroedinger.engr.sgi.com>
References: <20060625115736.d90e1241.akpm@osdl.org>
	<20060625211929.GA3865@localhost.localdomain>
	<20060626113950.571d3e4c.pj@sgi.com>
	<Pine.LNX.4.64.0606261142560.32190@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> 99:1 may be too small a ratio.

Could well be.  I was just quoting Ravikiran's number.  I suspect he
was using the number loosely, not as a precise value.


> A read_mostly marked variable should be changed rarely (meaning is 
> is extremely unlikely that his is going to change) but read frequently.

Yes - well said.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
