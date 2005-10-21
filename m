Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbVJUQ1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbVJUQ1f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVJUQ1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:27:34 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:44732 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965023AbVJUQ1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:27:34 -0400
Date: Fri, 21 Oct 2005 09:27:00 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: Simon Derr <Simon.Derr@bull.net>, Andrew Morton <akpm@osdl.org>,
       Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Magnus Damm <magnus.damm@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
In-Reply-To: <435896CA.1000101@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.62.0510210926120.23328@schroedinger.engr.sgi.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
 <20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
 <4358588D.1080307@jp.fujitsu.com> <Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>
 <435896CA.1000101@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2005, KAMEZAWA Hiroyuki wrote:

> > > How about this ?
> > > +cpuset_update_task_mems_allowed(task, new);    (this isn't implemented
> > > now
> 
> *new* is already guaranteed to be the subset of current mem_allowed.
> Is this violate the permission ?
 
Could the cpuset_mems_allowed(task) function update the mems_allowed if 
needed?

