Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVJUPSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVJUPSq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVJUPSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:18:46 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29887 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964977AbVJUPSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:18:45 -0400
Date: Fri, 21 Oct 2005 08:18:34 -0700
From: Paul Jackson <pj@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Simon.Derr@bull.net, clameter@sgi.com, akpm@osdl.org, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, magnus.damm@gmail.com,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
Message-Id: <20051021081834.056a44af.pj@sgi.com>
In-Reply-To: <435896CA.1000101@jp.fujitsu.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	<20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
	<4358588D.1080307@jp.fujitsu.com>
	<Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>
	<435896CA.1000101@jp.fujitsu.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kame wrote:
> *new* is already guaranteed to be the subset of current mem_allowed.
> Is this violate the permission ?

The question is not so much whether the current tasks mems_allowed
is violated, but whether the mems_allowed of the cpuset of the
task that owns the pages is violated.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
