Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317834AbSHHRnK>; Thu, 8 Aug 2002 13:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317815AbSHHRl4>; Thu, 8 Aug 2002 13:41:56 -0400
Received: from [63.204.6.12] ([63.204.6.12]:9144 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S317814AbSHHRlE>;
	Thu, 8 Aug 2002 13:41:04 -0400
Date: Thu, 8 Aug 2002 13:44:43 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: PCI hotplug resource reservation 
In-Reply-To: <27462.1028790802@redhat.com>
Message-ID: <Pine.LNX.4.33.0208081336420.26999-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, David Woodhouse wrote:

> scottm@somanetworks.com said:
> > I think the implications are pretty strong that programming bridges
> > with conflicting ranges will result in undefined behaviour.  Even if
> > it did work, doing so also has the potential to open us up to new
> > classes of bridge hardware bugs that no one has seen before.
>
> OK. That buggers that idea then :(

Do you have any objection to this boot time reservation stuff going in
for now as a cPCI only thing?  I can imagine other solutions that use
DMI scans or the like to detect cPCI master cards and grab chunks of the
resource space(s) for the hotswap buses, but don't have any clever ideas
on reliable heuristics for knowing how big those chunks should be for a
given card.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

