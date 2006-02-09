Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWBIUPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWBIUPJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 15:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWBIUPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 15:15:09 -0500
Received: from ns2.suse.de ([195.135.220.15]:22158 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750764AbWBIUPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 15:15:08 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: Terminate process that fails on a constrained allocation V3
Date: Thu, 9 Feb 2006 21:14:51 +0100
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, pj@sgi.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0602091152300.9941@schroedinger.engr.sgi.com> <200602092105.04412.ak@suse.de> <Pine.LNX.4.62.0602091209220.9952@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602091209220.9952@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602092114.51517.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 February 2006 21:12, Christoph Lameter wrote:

> > Doing this all properly would probably get quite messy.
> 
> I'd say making overcommit working nicely with MPOL_BIND is yet another 
> fundamental issue for the policy layer but it does not matter for this 
> patch.

I agree. Your patch is ok by me, although I think the earlier 
simpler patches would have done as well (it's slightly overengineered).
But not too bad.

-Andi
