Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161846AbWI2TrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161846AbWI2TrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161849AbWI2TrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:47:17 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21738 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161847AbWI2TrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:47:16 -0400
Date: Fri, 29 Sep 2006 12:47:01 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Valdis.Kletnieks@vt.edu
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm2 - oops in cache_alloc_refill()
In-Reply-To: <200609291519.k8TFJfvw004256@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.64.0609291246340.27456@schroedinger.engr.sgi.com>
References: <20060928014623.ccc9b885.akpm@osdl.org>
 <200609290319.k8T3JOwS005455@turing-police.cc.vt.edu>           
 <20060928202931.dc324339.akpm@osdl.org> <200609291519.k8TFJfvw004256@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006, Valdis.Kletnieks@vt.edu wrote:

> I may have to learn how to use 'git bisect' to shoot this one, it appears.

Or enable SLAB_DEBUG?

