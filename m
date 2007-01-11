Return-Path: <linux-kernel-owner+w=401wt.eu-S965263AbXAKAn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbXAKAn6 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 19:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbXAKAn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 19:43:58 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38381 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965263AbXAKAn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 19:43:57 -0500
Date: Wed, 10 Jan 2007 16:43:36 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: David Chinner <dgc@sgi.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
In-Reply-To: <20070111003158.GT33919298@melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0701101642080.23729@schroedinger.engr.sgi.com>
References: <20070110223731.GC44411608@melbourne.sgi.com>
 <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com>
 <20070110230855.GF44411608@melbourne.sgi.com> <45A57333.6060904@yahoo.com.au>
 <20070111003158.GT33919298@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are comparing a debian 2.6.18 standard kernel with your tuned version 
of 2.6.20-rc3. There may be a lot of differences. Could you get us the 
config? Or use the same config file and build 2.6.20/18 the same way.

