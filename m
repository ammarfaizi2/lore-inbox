Return-Path: <linux-kernel-owner+w=401wt.eu-S1030194AbXAKBlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbXAKBlE (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 20:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbXAKBlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 20:41:03 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:57306 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030194AbXAKBlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 20:41:01 -0500
Date: Wed, 10 Jan 2007 17:40:26 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: David Chinner <dgc@sgi.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
In-Reply-To: <20070111010605.GU33919298@melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0701101731590.24010@schroedinger.engr.sgi.com>
References: <20070110223731.GC44411608@melbourne.sgi.com>
 <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com>
 <20070110230855.GF44411608@melbourne.sgi.com> <45A57333.6060904@yahoo.com.au>
 <20070111003158.GT33919298@melbourne.sgi.com>
 <Pine.LNX.4.64.0701101642080.23729@schroedinger.engr.sgi.com>
 <20070111010605.GU33919298@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007, David Chinner wrote:

> On Wed, Jan 10, 2007 at 04:43:36PM -0800, Christoph Lameter wrote:
> > You are comparing a debian 2.6.18 standard kernel with your tuned version 
> > of 2.6.20-rc3. There may be a lot of differences. Could you get us the 
> > config? Or use the same config file and build 2.6.20/18 the same way.
> 
> I took the /proc/config.gz from the debian 2.6.18-1 kernel as the
> base config for the 2.6.20-rc3 kernel and did a make oldconfig on
> it to make sure it was valid for the newer kernel but pretty much
> the same. I think that's the right process, so I don't think
> different build configs are the problem here.

Debian may have added extra patches that are not upstream. I see f.e. some 
of my post 2.6.18 patches in there.
