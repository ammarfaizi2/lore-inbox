Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265769AbUBKTTa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266150AbUBKTTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:19:30 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:18414 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S265769AbUBKTT3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:19:29 -0500
Date: Wed, 11 Feb 2004 11:19:22 -0800
From: Larry McVoy <lm@bitmover.com>
To: Bryan Whitehead <driver@jpl.nasa.gov>
Cc: M?ns Rullg?rd <mru@kth.se>, linux-kernel@vger.kernel.org, lm@bitmover.com
Subject: Re: reiserfs for bkbits.net?
Message-ID: <20040211191922.GA31404@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Bryan Whitehead <driver@jpl.nasa.gov>, M?ns Rullg?rd <mru@kth.se>,
	linux-kernel@vger.kernel.org, lm@bitmover.com
References: <200402111523.i1BFNnOq020225@work.bitmover.com> <20040211161358.GA11564@favonius> <yw1xisidino2.fsf@kth.se> <402A747C.8020100@jpl.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402A747C.8020100@jpl.nasa.gov>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 10:29:16AM -0800, Bryan Whitehead wrote:
> http://pcbunn.cacr.caltech.edu/gae/3ware_raid_tests.htm
> 
> They needed 200MByte/sec disk transfer speed. this is how they got it.

Our workload is MUCH less friendly than bonnie.  We typically have lots
of traffic spread over lots of small files.  With 1-3 outstanding 
requests (i.e., just at the point where disk sort does you little good).
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
