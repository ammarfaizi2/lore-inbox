Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUJLPmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUJLPmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUJLPl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:41:59 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:53709 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265207AbUJLPlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:41:51 -0400
Date: Tue, 12 Oct 2004 08:39:16 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Rik van Riel <riel@redhat.com>
cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, linux-mm@kvack.org
Subject: Re: NUMA: Patch for node based swapping
In-Reply-To: <Pine.LNX.4.44.0410121126390.13693-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0410120838570.12195@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0410121126390.13693-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Rik van Riel wrote:
> On Tue, 12 Oct 2004, Christoph Lameter wrote:
> > The minimum may be controlled through /proc/sys/vm/node_swap.
> > By default node_swap is set to 100 which means that kswapd will be run on
> > a zone if less than 10% are available after allocation.
> That sounds like an extraordinarily bad idea for eg. AMD64
> systems, which have a very low numa factor.

Any other suggestions?

