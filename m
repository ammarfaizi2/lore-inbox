Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274084AbRIXRlQ>; Mon, 24 Sep 2001 13:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274082AbRIXRlE>; Mon, 24 Sep 2001 13:41:04 -0400
Received: from opengraphics.com ([216.208.162.194]:36235 "EHLO
	hurricane.opengraphics.com") by vger.kernel.org with ESMTP
	id <S274081AbRIXRko>; Mon, 24 Sep 2001 13:40:44 -0400
Date: Mon, 24 Sep 2001 13:41:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Problem with md software raid in 2.4.10 (2.4.9 works it seems)
Message-ID: <20010924134110.A25448@concord.opengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: Len Sorensen <lsorense@opengraphics.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a problem with the md software raid in 2.4.10.  I have
tried 2.4.10 final and 2.4.10-pre13, and both exhibit the same problem.
The problem does not appear in 2.4.9 so far.

The problem is that when adding a device to a degraded raid, the system
locks up.  If I boot 2.4.9 it adds it fine, and starts the recovery.
If the raid is recovered, 2.4.10 boots fine of the raid.

The system is using 2 x 18G IBM U160 hot swap scsi drives on an aic7xxx
controller.

Does anyone know what the md changes between 2.4.9 and 2.4.10 were and
if any of them could be causing the lockups I am seeing?

It seems like occationally 2.4.10 will succeed at adding a drive to the
raid without crashing, but most of the time it does crash.

Please let me know if there is any logs or such that I can provide to
possibly help figure out what is going on.

The system is an IBM 8654-51Y.  P3 1GHz, 256M ram.

Len Sorensen
