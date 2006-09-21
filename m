Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWIUAwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWIUAwH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWIUAwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:52:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14491 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750891AbWIUAwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:52:04 -0400
Date: Wed, 20 Sep 2006 17:51:52 -0700
From: Paul Jackson <pj@sgi.com>
To: sekharan@us.ibm.com
Cc: menage@google.com, npiggin@suse.de, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, devel@openvz.org,
       clameter@sgi.com
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920175152.25dcf5ca.pj@sgi.com>
In-Reply-To: <1158799559.6536.120.camel@linuxchandra>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158777240.6536.89.camel@linuxchandra>
	<6599ad830609201143h19f6883wb388666e27913308@mail.google.com>
	<1158778496.6536.95.camel@linuxchandra>
	<6599ad830609201225k3d38afe2gea7adc2fa8067e0@mail.google.com>
	<20060920134903.fbd9fea8.pj@sgi.com>
	<1158799559.6536.120.camel@linuxchandra>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra wrote:
> > It seems that cpusets can mimic memory resource groups.  I don't
> 
> I am little confused w.r.t how cpuset can mimic memory resource groups.
> How can cpuset provide support for over commit.

I didn't say "mimic well" ;).

I had no clue cpusets could do overcommit at all, though Paul Menage just
posted a notion of how to mimic overcommit, with his post beginning:

> I have some patches locally that basically let you give out a small
> set of nodes initially to a cpuset, and if memory pressure in
> try_to_free_pages() passes a specified threshold, automatically
> allocate one of the parent cpuset's unused memory nodes to the child
> cpuset, up to specified limit.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
