Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVERBHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVERBHf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 21:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVERBHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 21:07:35 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:55168 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261995AbVERBHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 21:07:24 -0400
Date: Tue, 17 May 2005 18:07:16 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2 boot failure
In-Reply-To: <919250000.1116372164@flay>
Message-ID: <Pine.LNX.4.62.0505171806430.12337@schroedinger.engr.sgi.com>
References: <735450000.1116277481@flay> <20050516142504.696b443b.akpm@osdl.org>
 <743780000.1116279381@flay> <919250000.1116372164@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005, Martin J. Bligh wrote:

> > OK, fair enough. Christoph, I am interested in seeing your patch work 
> > ... is something that's needed. If you want, I can help you offline 
> > with some testing on a variety of platforms.
> 
> OK, I backed out the slab patches from -mm2, and confirmed the problem 
> went away.

Is there any way I can access the system to figure out what is wrong? The 
failure is in the page allocator and it seems that a node id is wrong.

