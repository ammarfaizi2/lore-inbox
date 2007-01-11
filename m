Return-Path: <linux-kernel-owner+w=401wt.eu-S1751307AbXAKRvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbXAKRvb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbXAKRvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:51:31 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:48773 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751307AbXAKRva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:51:30 -0500
Date: Thu, 11 Jan 2007 09:51:15 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: David Chinner <dgc@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [REGRESSION] 2.6.19/2.6.20-rc3 buffered write slowdown
In-Reply-To: <45A602F0.1090405@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0701110950380.28802@schroedinger.engr.sgi.com>
References: <20070110223731.GC44411608@melbourne.sgi.com>
 <Pine.LNX.4.64.0701101503310.22578@schroedinger.engr.sgi.com>
 <20070110230855.GF44411608@melbourne.sgi.com> <45A57333.6060904@yahoo.com.au>
 <20070111003158.GT33919298@melbourne.sgi.com> <45A58DFA.8050304@yahoo.com.au>
 <20070111012404.GW33919298@melbourne.sgi.com> <45A602F0.1090405@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007, Nick Piggin wrote:

> You're not turning on zone_reclaim, by any chance, are you?

It is not a NUMA system so zone reclaim is not available. zone reclaim was 
already in 2.6.16.
