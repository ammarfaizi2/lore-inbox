Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWGYU0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWGYU0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWGYU0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:26:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:45725 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932489AbWGYU0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:26:14 -0400
Date: Tue, 25 Jul 2006 13:25:46 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Rik van Riel <riel@redhat.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm <linux-mm@kvack.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: inactive-clean list
In-Reply-To: <44C518D6.3090606@redhat.com>
Message-ID: <Pine.LNX.4.64.0607251324140.30939@schroedinger.engr.sgi.com>
References: <1153167857.31891.78.camel@lappy> <44C30E33.2090402@redhat.com>
 <Pine.LNX.4.64.0607241109190.25634@schroedinger.engr.sgi.com>
 <44C518D6.3090606@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2006, Rik van Riel wrote:

> > I think there may be a way with less changes to the way the VM functions to
> > get there:
> 
> That approach probably has way too many state changes going
> between the guest OS and the hypervisor...

An increment of a VM counter causes a state change in the hypervisor?
