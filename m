Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbTLRTN1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 14:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbTLRTN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 14:13:27 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:30961 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265284AbTLRTN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 14:13:26 -0500
Date: Thu, 18 Dec 2003 11:13:18 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Martin Knoblauch <knobi@knobisoft.de>, linux-kernel@vger.kernel.org
Subject: Re: RAID-0 read perf. decrease after 2.4.20
Message-ID: <20031218191318.GC6438@matchmail.com>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Martin Knoblauch <knobi@knobisoft.de>, linux-kernel@vger.kernel.org
References: <20031216125103.6301.qmail@web13903.mail.yahoo.com> <Pine.LNX.4.44.0312181140540.4547-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312181140540.4547-100000@logos.cnet>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 11:41:11AM -0200, Marcelo Tosatti wrote:
> On Tue, 16 Dec 2003, Martin Knoblauch wrote:
> >  Just some feedback:
> > 
> > echo 511 > /proc/sys/vm/max-readahead
> > 
> >  brings back the read performance of my 30 disks on 4 controller
> > LVM/RAID0.
> 
> Great.

Maybe a new default is in order?
