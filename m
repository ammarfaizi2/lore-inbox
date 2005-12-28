Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbVL1GNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbVL1GNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 01:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVL1GNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 01:13:16 -0500
Received: from hera.kernel.org ([140.211.167.34]:45697 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932483AbVL1GNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 01:13:16 -0500
Date: Tue, 27 Dec 2005 22:10:47 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
Message-ID: <20051228001047.GA3607@dmt.cnet>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Tue, Dec 27, 2005 at 08:58:39AM -0800, Chris Stromsoe wrote:
> I have a machine that oopsed twice in the last 3 weeks.  Immediately 
> before each oops was a "filemap.c:2234: bad pmd" message.  The first oops 
> happened with 2.4.30, the second with 2.4.32.  The oops from 2.4.30 is 
> below.  I don't have the oops from 2.4.32.
> 
> The machine is a usenet feeder and does a constant ~110mbit/s traffic.  I 
> have the tg3 and bonding modules loaded.  There are 2 Adaptec controllers, 
> one onboard, one pci (aic7899 and 3960D).  There are 5 disks off the first 
> channel of aic7899 (comes up as scsi2), 4 of which are in a RAID5.  The 
> other 3 channels are unused.  I have the .config for 2.4.30 available if 
> needed.
> 
> Pointers for where to look if/when it happens again would be appreciated. 
>
> Thanks.
> 
> 
> -Chris
> 
> filemap.c:2234: bad pmd 00c001e3.
> filemap.c:2234: bad pmd 010001e3.

This is usually due to memory corruption. Please verify it with
memtest86.


