Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269939AbUJNBWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269939AbUJNBWG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 21:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269942AbUJNBWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 21:22:06 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:53148 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269939AbUJNBWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 21:22:04 -0400
Subject: Re: 4level page tables for Linux
From: Albert Cahalan <albert@users.sf.net>
To: Andrea Arcangeli <andrea@novell.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, ak@suse.de
In-Reply-To: <20041013235118.GR17849@dualathlon.random>
References: <1097709734.2666.10890.camel@cube>
	 <20041013235118.GR17849@dualathlon.random>
Content-Type: text/plain
Organization: 
Message-Id: <1097716542.2673.11007.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Oct 2004 21:15:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 19:51, Andrea Arcangeli wrote:
> On Wed, Oct 13, 2004 at 07:22:15PM -0400, Albert Cahalan wrote:
> > I'd number going toward the page, because that's
> > the order in which these things get walked.
> 
> I'd call the pml level 1 too, but in the specs is level 4.  So sticking
> the specs numbering is going to generate less confusion. Otherwise when
> we speak with somebody with hardware knowledge we say level 4 and he
> understand the specs's level 1. I recall it already happened to me once ;).

While x86_64 will be by far the most popular arch,
this is a matter for the generic code.

Perhaps "4" should be avoided: 0,1,2,3


