Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbTLRNxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 08:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265145AbTLRNxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 08:53:16 -0500
Received: from intra.cyclades.com ([64.186.161.6]:26262 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265144AbTLRNxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 08:53:13 -0500
Date: Thu, 18 Dec 2003 11:41:11 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Martin Knoblauch <knobi@knobisoft.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAID-0 read perf. decrease after 2.4.20
In-Reply-To: <20031216125103.6301.qmail@web13903.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0312181140540.4547-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Dec 2003, Martin Knoblauch wrote:

> On Monday 08 December 2003 13:47, Marcelo Tosatti wrote:
> 
> Hi Marcelo,
> 
> > 2.4.20-aa included rmap and some VM modifications most notably
> > "drop_behind()" logic which I believe should be the reason for the
> huge
> > read speedups. Can you please try it? Against 2.4.23.
> 
>  Just some feedback:
> 
> echo 511 > /proc/sys/vm/max-readahead
> 
>  brings back the read performance of my 30 disks on 4 controller
> LVM/RAID0.

Great.

