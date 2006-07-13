Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161003AbWGMWae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWGMWae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 18:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWGMWae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 18:30:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11394 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161003AbWGMWad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 18:30:33 -0400
Date: Thu, 13 Jul 2006 18:30:29 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: memory corruptor in .18rc1-git
Message-ID: <20060713223029.GD3371@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <20060713221330.GB3371@redhat.com> <20060713152425.86412ea3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060713152425.86412ea3.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 03:24:25PM -0700, Andrew Morton wrote:

 > > I've up'd the speed of the serial console, in the hope that more chars
 > > make it over the wire before reboot should this happen again.
 > 
 > Are you using SMP?  We have a known slab locking bug.

Yes, dual EM64T's with HT.

 > There have been a couple of slab.c patches committed today, but neither of
 > them appear to actually fix the bug.
 > 
 > The below should fix it, and testing this (disable lockdep) would be
 > useful.

I can give it a shot, but as it takes a while for this to manifest, I may
not be able to say for certain whether it fixes it or not.

		Dave
 
-- 
http://www.codemonkey.org.uk
