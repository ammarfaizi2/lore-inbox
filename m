Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161414AbWASUQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161414AbWASUQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161409AbWASUP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:15:59 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:38028 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1161411AbWASUP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:15:58 -0500
Date: Thu, 19 Jan 2006 21:14:28 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Phillip Susi <psusi@cfl.rr.com>
cc: govind raj <agovinda04@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: RAID 5+0 support
In-Reply-To: <43CFE34F.8060309@cfl.rr.com>
Message-ID: <Pine.LNX.4.60.0601192113030.14341@kepler.fjfi.cvut.cz>
References: <BAY109-F267E92D32B75385FDB680DD61C0@phx.gbl> <43CFCBB2.3050003@cfl.rr.com>
 <Pine.LNX.4.60.0601191933250.14341@kepler.fjfi.cvut.cz> <43CFE34F.8060309@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Phillip Susi wrote:

> Martin Drab wrote:
> > Speed is the issue here, I believe. By stripping two RAID-5 arrays you ought
> > to get the reliability of the RAID-5 but with considerably higher speed.
> > That's basically why RAID-50 exists, I think.
> 
> One big raid-5 would have higher speed because it would have one more disk
> allocated to storing data rather than more parity.  The raid 5+0 isn't really
> going to be any more reliable because it can withstand a single failure in
> either half, but not two failures in one half, so in the face of a double
> failure, you have a 50/50 chance of one being in each half. 

Well, yes and no. See for instance:

http://en.wikipedia.org/wiki/RAID#RAID_50_.28RAID_5.2B0.29

Martin
