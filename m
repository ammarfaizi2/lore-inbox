Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWEPQAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWEPQAS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWEPQAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:00:18 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:13543 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751596AbWEPQAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:00:15 -0400
Date: Tue, 16 May 2006 09:00:02 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Con Kolivas <kernel@kolivas.org>
cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-mm@kvack.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mm: cleanup swap unused warning
In-Reply-To: <200605162314.36059.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.64.0605160859230.6065@schroedinger.engr.sgi.com>
References: <200605102132.41217.kernel@kolivas.org>
 <Pine.LNX.4.64.0605101604330.7472@schroedinger.engr.sgi.com>
 <200605162055.36957.kernel@kolivas.org> <200605162314.36059.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006, Con Kolivas wrote:

> The variable is not compiled in so the empty static inline as suggested by
> Pekka suffices to silence this warning.

Maybe you could redo the whole thing? Is it a problem to make all the 
similar functions inlines?
