Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWGDPUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWGDPUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWGDPUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:20:50 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:31421 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750815AbWGDPUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:20:49 -0400
Date: Tue, 4 Jul 2006 08:20:25 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       hugh@veritas.com, kernel@kolivas.org, marcelo@kvack.org,
       nickpiggin@yahoo.com.au, ak@suse.de
Subject: Re: [RFC 3/8] Move HIGHMEM counter into highmem.c/.h
In-Reply-To: <20060703232020.260446d9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607040819230.13534@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
 <20060703215550.7566.79975.sendpatchset@schroedinger.engr.sgi.com>
 <20060704144724.65c43a38.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0607032253040.10856@schroedinger.engr.sgi.com>
 <20060703232020.260446d9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006, Andrew Morton wrote:

> > Ok. Will put a #ifdef CONFIG_HIGHMEM around that statement and the 
> > following one.
> 
> That will take the patchset up to 27 new ifdefs.  Is there a way of improving
> that?

Ideas are welcome. I can put some of the tests for zones together into one
big #ifdef in mmzone.h but otherwise this is going to be difficult.

