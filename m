Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271932AbTGYGsh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 02:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271934AbTGYGsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 02:48:37 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:43788 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S271932AbTGYGsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 02:48:36 -0400
Message-Id: <200307250654.h6P6s9j05200@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Bernd Eckenfels <ecki-lkm@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Net device byte statistics
Date: Fri, 25 Jul 2003 10:03:32 +0300
X-Mailer: KMail [version 1.3.2]
References: <E19fqMF-0007me-00@calista.inka.de>
In-Reply-To: <E19fqMF-0007me-00@calista.inka.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 July 2003 03:22, Bernd Eckenfels wrote:
> In article <200307250156.47108.fredrik@dolda2000.cjb.net> you wrote:
> > On the other hand, I cannot imagine that noone would have thought of it. What 
> > is the reason for this? Is there another interface that I should use instead 
> > of /proc/net/dev to gather byte statistics for interfaces?
> 
> it is for performance reasons. You can
> 
> a) collect your numbers more often and asume wrap/reboot  if numbers
> decrease
> b) use iptables counters instead
> 
> BTW: it is a very often discussed topic, personally (as net tools
> maintainer) I would love to see 64bit counters here, but this still means
> you have to sample often enough, so you do not lose numbers on crash.

I sample the data every minute. Will need to do it much more often
on 10ge ifaces, when those will appear at my home ;)

Or we will need 64bit counters then.
--
vda
