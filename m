Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTLOL0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 06:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTLOL0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 06:26:38 -0500
Received: from intra.cyclades.com ([64.186.161.6]:62595 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263518AbTLOL0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 06:26:37 -0500
Date: Mon, 15 Dec 2003 09:24:33 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Vladimir Saveliev <vs@namesys.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.23] kernel BUG at page_alloc.c:235!
In-Reply-To: <200312091907.04707.vs@namesys.com>
Message-ID: <Pine.LNX.4.44.0312150923540.1344-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Dec 2003, Vladimir Saveliev wrote:

> On Tuesday 09 December 2003 18:59, Stephan von Krawczynski wrote:
> > On Mon, 8 Dec 2003 19:39:07 +0300
> > Vladimir Saveliev <vs@namesys.com> wrote:
> > 
> > > Hi
> > > 
> > > A program which reads spontaneously 4k blocks from a device (sda1) causes the following quite fast.
> > 
> > > [...]
> > > Ksymoops provides
> > > 
> > > vs@tribesman:/tmp/> ksymoops -m System.map file2 -V -O -K
> > > ksymoops 2.4.9 on i686 2.4.21-144-default.  Options used
> > 
> > What kind of a kernel is this? Are you sure you are running 2.4.23 ?
> > 
> Yes, oops happened on 2.4.23. I ksymoopsed it with proper System.map having 2.4.21-144 running, though

After tracking this down we discovered its hardware problem (motherboard 
was changed and the problem has vanished).



