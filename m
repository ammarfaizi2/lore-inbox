Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751935AbWCAWwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbWCAWwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751936AbWCAWwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:52:22 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:8682 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751935AbWCAWwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:52:21 -0500
Date: Wed, 1 Mar 2006 14:52:11 -0800
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: ak@suse.de, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Message-Id: <20060301145211.50ed98d2.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0603011411190.31997@schroedinger.engr.sgi.com>
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
	<200603012159.42273.ak@suse.de>
	<20060301131910.beb949be.pj@sgi.com>
	<200603012221.37271.ak@suse.de>
	<Pine.LNX.4.64.0603011411190.31997@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, as to what should be the default for this, enabling or not
enabling memory spreading on these inode and similar such slab caches,
I will have to leave that up to others more expert than I.

I am content to suggest that the default should reflect either the
current default (no spreading, as such was not an option until now) or
what is best for the majority of systems (whatever that is).

Probably best not to change the default, unless there is a clear
concensus that it's wrong in the majority of cases.

Whatever systems don't like the default can change it easily enough,
one way or the other.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
