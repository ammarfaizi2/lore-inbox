Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbTAJRzK>; Fri, 10 Jan 2003 12:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbTAJRzK>; Fri, 10 Jan 2003 12:55:10 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:18599 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S265475AbTAJRzI>; Fri, 10 Jan 2003 12:55:08 -0500
Date: Fri, 10 Jan 2003 10:02:10 -0800
From: Anthony Lau <anthony@greyweasel.com>
Subject: Re: Kernel Oops with HIMEM+VM in 2.4.19,20
In-reply-to: <200301100908.h0A98ks15321@Port.imtp.ilyichevsk.odessa.ua>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Message-id: <20030110180210.GA1292@kimagure>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <20030110083714.GA702@kimagure>
 <200301100908.h0A98ks15321@Port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 11:08:39AM +0200, Denis Vlasenko wrote:
> On 10 January 2003 10:37, Anthony Lau wrote:
> > Hello,
> >
[snip]
> 
> You mean when your system starts to swap? Details?
> (How much/how heavy it swaps before oops? vmstat output?)

With very little swapping and <10MB of VM in use as reported by
the "free" command (Debian SID).
Next time I get an oops I will get the vmstat output.

[snip]

> Kernel version and .config?
> Arrange klogd to be started with -x. Process oopses with ksymoops.

I have tried vanilla 2.4.19+HTB2 patch and vanilla 2.4.20.
I have setup klogd with -x now and await the next oops.

Thanks for the list of VM people. They were not obviously listed
in the MAINTAINER file that came with the kernel sources.

--
Anthony
