Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267685AbUI1Mf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267685AbUI1Mf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 08:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUI1Mf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 08:35:58 -0400
Received: from smtp-vbr11.xs4all.nl ([194.109.24.31]:62481 "EHLO
	smtp-vbr11.xs4all.nl") by vger.kernel.org with ESMTP
	id S267685AbUI1Mfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 08:35:43 -0400
Subject: Re: [OT] Microsoft claim 267% better peak performance than linux?
From: Norbert van Nobelen <Norbert@edusupport.nl>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200409281524.25187.vda@port.imtp.ilyichevsk.odessa.ua>
References: <20040928075545.GA3298@cenedra.walrond.org>
	 <200409281524.25187.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Organization: 
Message-Id: <1096374908.21271.38.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 28 Sep 2004 14:35:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The document shows some interesting points though:
- They describe what they did to make redhat/apache perform better
- ISAPI is pretty fast compared to CGI (Didn't apache recently release a
programming interface which is cross platform and does something like
this too?)
- Multithreading works in their advantage (Compare 2003 normal against
multithreaded, maybe too little amount of apache threads running, or
some optimization needed in the linux kernel here?)
And last but not least:
WIndows 2003 suddenly realizes that is has a few CPU's left and starts
using them (-: See the graphs where there is a weird bent in the 8 CPU
curve.

And it still doesn't matter actually: 286% faster is still about 3 times
more expensive, which is the point on which is must be compared (lower
TCO because we are faster, so MS TCO is lower, but still too high)



On Tue, 2004-09-28 at 17:24, Denis Vlasenko wrote:
> On Tuesday 28 September 2004 07:55, Andrew Walrond wrote:
> > I was pointed to this (rotating) banner advert at the top of www.eweek.com
> >
> > It claims that when comparing Red Hat AS2.1 with Windows Server 2003 on a
> > dual processor machine, Windows Server 2003 gives 276% better peak
> > performance, quoting Veritest as the source.
> 
> It is very easy to 'slightly' misconfigure Linux machine so that it
> slows to a crawl. For webservers, classic way to do it is to force
> Apache to log a fqdn of incoming connections instead of numeric IP.
> 
> From pdf:
> > Microsoft commissioned VeriTest, a division of Lionbridge
> > Technologies, Inc., to conduct a series of tests comparing
> > the Web serving performance of the following server operating
> > system configurations running on a variety of server hardware
> > and processor configurations...
> 
> Do you seriously expect that MS-funded tests can ever find Linux
> to be faster?
-- 
Met vriendelijke groet,

Norbert van Nobelen
EduSupport

Postbus 95963
2509CZ Den Haag
T: 070-3280200
M: 06-43036586
F: 070-3280029
E: Norbert@edusupport.nl
I: www.edusupport.nl
B: ABN AMRO
R: 47.38.00.411

