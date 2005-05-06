Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVEFS4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVEFS4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 14:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVEFS4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 14:56:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8702 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261261AbVEFS4H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 14:56:07 -0400
Date: Fri, 6 May 2005 11:56:01 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Priority Lists for the RT mutex
In-Reply-To: <427B5147.36DE54D1@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0505061155440.14099-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2005, Oleg Nesterov wrote:

> Oleg Nesterov wrote:
> >
> > Daniel Walker wrote:
> > >
> > > Description:
> > > 	This patch adds the priority list data structure from Inaky Perez-Gonzalez
> > > to the Preempt Real-Time mutex.
> > >
> > ...
> >
> > I can't understand how this can work.
> 
> And I think it is possible to simplify plist's design.
> 
> struct plist {
> 	int prio;
> 	struct list_head prio_list;
> 	struct list_head node_list;
> };
> 

Make a patch .

Daniel

