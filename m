Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311914AbSCOCwt>; Thu, 14 Mar 2002 21:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311915AbSCOCwj>; Thu, 14 Mar 2002 21:52:39 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:43201 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S311914AbSCOCwd>; Thu, 14 Mar 2002 21:52:33 -0500
Date: Thu, 14 Mar 2002 19:52:31 -0700
Message-Id: <200203150252.g2F2qVM15051@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: linux-kernel@vger.kernel.org
Subject: VGA blank causes hang with 2.4.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. Here's a perverse problem: when the screen blanks (text
console) with 2.4.18, the machine hangs. No ping response, no magic
SysReq response. I didn't have this problem with 2.4.7.

The command I used to configure screen blanking was:
setterm -blank 10 -powerdown 0

This is an Athalon 850 MHz on a Gigabyte GA-7ZM motherboard.

I managed to waste a few hours chasing this, wondering why the machine
hung a while after boot. Of course, I first blamed the jobs that were
started on it soon after boot. Turns out the jobs are not to blame!

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
