Return-Path: <linux-kernel-owner+w=401wt.eu-S1761865AbWLIUDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761865AbWLIUDf (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 15:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761867AbWLIUDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 15:03:35 -0500
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:49669 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761865AbWLIUDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 15:03:34 -0500
Date: Sat, 9 Dec 2006 15:03:23 -0500
From: Kyle McMartin <kyle@ubuntu.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: noexec=on doesn't work
Message-ID: <20061209200323.GA21514@athena.road.mcmartin.ca>
References: <457B0FD7.2030804@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457B0FD7.2030804@comcast.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2006 at 02:34:47PM -0500, John Richard Moser wrote:
> I have filed this as a distro bug with Ubuntu; it may be their issue, I
> haven't dug deep enough to find out.  I am posting this here to disperse
> the information breadth-first instead of depth-first, which will shorten
> the bug's life cycle if it turns out to be an upstream bug.
> 

NX requires the 64-bit page table entries (ie, PAE) which requires
CONFIG_HIGHMEM64G.

Why are you posting to linux-kernel@ without even checking the upstream
kernel, anyway?

plonk.

	Kyle M.
