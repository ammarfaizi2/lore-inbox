Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271936AbTGYGzA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 02:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271937AbTGYGzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 02:55:00 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:9988 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id S271936AbTGYGy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 02:54:56 -0400
Date: Fri, 25 Jul 2003 00:01:30 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Bernd Eckenfels <ecki-lkm@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Net device byte statistics
In-Reply-To: <200307250654.h6P6s9j05200@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.10.10307250000460.22736-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Denis,

@ $7K per card you will not have to worry for a while :-O

-a

On Fri, 25 Jul 2003, Denis Vlasenko wrote:

> On 25 July 2003 03:22, Bernd Eckenfels wrote:
> > In article <200307250156.47108.fredrik@dolda2000.cjb.net> you wrote:
> > > On the other hand, I cannot imagine that noone would have thought of it. What 
> > > is the reason for this? Is there another interface that I should use instead 
> > > of /proc/net/dev to gather byte statistics for interfaces?
> > 
> > it is for performance reasons. You can
> > 
> > a) collect your numbers more often and asume wrap/reboot  if numbers
> > decrease
> > b) use iptables counters instead
> > 
> > BTW: it is a very often discussed topic, personally (as net tools
> > maintainer) I would love to see 64bit counters here, but this still means
> > you have to sample often enough, so you do not lose numbers on crash.
> 
> I sample the data every minute. Will need to do it much more often
> on 10ge ifaces, when those will appear at my home ;)
> 
> Or we will need 64bit counters then.
> --
> vda
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

