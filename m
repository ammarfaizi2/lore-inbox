Return-Path: <linux-kernel-owner+w=401wt.eu-S1030302AbXAEDx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbXAEDx5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 22:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbXAEDx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 22:53:57 -0500
Received: from mail0.lsil.com ([147.145.40.20]:44100 "EHLO mail0.lsil.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030302AbXAEDx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 22:53:57 -0500
Date: Thu, 4 Jan 2007 20:55:26 -0700
From: Eric Moore <eric.moore@lsil.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Justin Rosander <myrddinemrys@neo.rr.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: PROBLEM: LSIFC909 mpt card fails to recognize devices
Message-ID: <20070105035526.GA14185@lsil.com>
References: <1167955606.5133.13.camel@localhost> <20070104165922.137c6df9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104165922.137c6df9.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 04:59:22PM -0800, Andrew Morton wrote:
> On Thu, 04 Jan 2007 19:06:46 -0500
> Justin Rosander <myrddinemrys@neo.rr.com> wrote:
> 
> > Please forward this to the appropriate maintainer.  Thank you.
> > 
> > [1.] One line summary of the problem:    My fibre channel drives fail to
> > be recognized by my LSIFC909 card. 
> 
> Please send the output of `lspci -vn'
> -

Recompile the driver with MPT_DEBUG_INIT enabled in the driver Makefile,
and repost the output.

Eric Moore

