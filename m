Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129300AbRB1WGK>; Wed, 28 Feb 2001 17:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129305AbRB1WFv>; Wed, 28 Feb 2001 17:05:51 -0500
Received: from ma-northadams1-47.nad.adelphia.net ([24.51.236.47]:53254 "EHLO
	sparrow.net") by vger.kernel.org with ESMTP id <S129300AbRB1WFa>;
	Wed, 28 Feb 2001 17:05:30 -0500
Date: Wed, 28 Feb 2001 17:00:30 -0500
From: Eric Buddington <eric@sparrow.nad.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: time drift and fb comsole activity
Message-ID: <20010228170030.C2122@sparrow.nad.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this has been reported on the list recently, but I think I can
provide better detail. I'm running 2.4.2 with atyfb on a K6-2/266
running at 250. This system has no history of clock problems.

adjtimex-1.12 --compare gives me "2nd diff" readings of -0.01 in quiescent
conditions.

flipping consoles rapidly cboosts this number to -3 or -4.

catting the full documentation to ntpd (seemed appropriate) gives me
"2nd diff" numbers a little over 34. If I read the numbers correctly,
47 seconds of CMOS time passed while the system clock only passed 13
seconds.

The processor and the CMOS clock were moving at zero velocity relative
to each other, and were both in normal Earth gravity.

I would appreciate cc's of replies (ore requests for further
information), as I am not subscribed.

-Eric
