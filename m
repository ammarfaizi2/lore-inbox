Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbTLRTiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 14:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265302AbTLRTiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 14:38:54 -0500
Received: from intra.cyclades.com ([64.186.161.6]:30385 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265301AbTLRTiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 14:38:51 -0500
Date: Thu, 18 Dec 2003 17:17:31 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Martin Knoblauch <knobi@knobisoft.de>, linux-kernel@vger.kernel.org
Subject: Re: RAID-0 read perf. decrease after 2.4.20
In-Reply-To: <20031218191318.GC6438@matchmail.com>
Message-ID: <Pine.LNX.4.58L.0312181714090.23845@logos.cnet>
References: <20031216125103.6301.qmail@web13903.mail.yahoo.com>
 <Pine.LNX.4.44.0312181140540.4547-100000@logos.cnet> <20031218191318.GC6438@matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Dec 2003, Mike Fedyk wrote:

> On Thu, Dec 18, 2003 at 11:41:11AM -0200, Marcelo Tosatti wrote:
> > On Tue, 16 Dec 2003, Martin Knoblauch wrote:
> > >  Just some feedback:
> > >
> > > echo 511 > /proc/sys/vm/max-readahead
> > >
> > >  brings back the read performance of my 30 disks on 4 controller
> > > LVM/RAID0.
> >
> > Great.
>
> Maybe a new default is in order?

I believe the defaults have been changed because they harm smaller
workloads.

