Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUASBVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 20:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbUASBVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 20:21:51 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:64421 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261270AbUASBVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 20:21:50 -0500
Date: Sun, 18 Jan 2004 19:21:44 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Overlapping MTRRs in 2.6.1
In-Reply-To: <20040118215711.GE1748@srv-lnx2600.matchmail.com>
Message-ID: <Pine.LNX.4.58.0401181918590.977@ryanr.aptchi.homelinux.org>
References: <Pine.LNX.4.58.0401181458080.2194@ryanr.aptchi.homelinux.org>
 <20040118215711.GE1748@srv-lnx2600.matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jan 2004, Mike Fedyk wrote:

> On Sun, Jan 18, 2004 at 03:11:27PM -0600, Ryan Reich wrote:
> > My video card is a Radeon 7000, 64M of memory; processor, Athlon 2600+;
> > motherboard, Shuttle AN35N with NForce2 chipset.
>
> Can you try a few -mm kernels and see if there is any improvement?  Also,
> did you get any problems with 2.6.0?
>

Tried all the -mm kernels (-mm1 through -mm4) and 2.6.0, to no avail.  The
suggestion made by Lenar in response to my original inqiry is effective, in that
it eliminates the mtrr conflict.  However, it does NOT eliminate the
radeon_unlock problem, so I guess I was wrong about that.

-- 
Ryan Reich
ryanr@uchicago.edu
