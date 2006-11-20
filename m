Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966116AbWKTQUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966116AbWKTQUr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966117AbWKTQUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:20:47 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:5047 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S966116AbWKTQUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:20:46 -0500
Date: Mon, 20 Nov 2006 08:20:13 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RFC 1/7] Remove declaration of sighand_cachep from slab.h
In-Reply-To: <20061118172739.30538d16.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0611200817020.16173@schroedinger.engr.sgi.com>
References: <20061118054342.8884.12804.sendpatchset@schroedinger.engr.sgi.com>
 <20061118054347.8884.36259.sendpatchset@schroedinger.engr.sgi.com>
 <20061118172739.30538d16.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2006, Stephen Rothwell wrote:

> Is there no suitable header file to put this in?

There is only a single file that uses sighand_cachep apart from where it 
was defined. If we would add it to signal.h then we would also have to
add an include for slab.h just for this statement. I cannot imagine
any reason why one would have to use sighand_cachep outside of those two 
files.

