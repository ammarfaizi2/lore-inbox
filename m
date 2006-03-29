Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWC2WRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWC2WRz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 17:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWC2WRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 17:17:54 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:29638 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751006AbWC2WRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 17:17:54 -0500
Date: Wed, 29 Mar 2006 14:17:45 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Boehm, Hans" <hans.boehm@hp.com>
cc: "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@free.fr>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
In-Reply-To: <65953E8166311641A685BDF71D865826A23D0E@cacexc12.americas.cpqcorp.net>
Message-ID: <Pine.LNX.4.64.0603291415140.23901@schroedinger.engr.sgi.com>
References: <65953E8166311641A685BDF71D865826A23D0E@cacexc12.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2006, Boehm, Hans wrote:

> Somewhat improved slides for the talk Grant is referring to are at
> http://www.hpl.hp.com/personal/Hans_Boehm/misc_slides/pldi05_threads.pdf

Hmm.. A paper on that subject would be better. Cannot get much from the 
slides.

> It's hard to get this stuff right.  But we knew that.

Could you come up with a proposal how to correctly define and API to bit 
ops in such a way that they work for all architectures and allow us to 
utilize all the features that processors may have?
