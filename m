Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281819AbRKVXzu>; Thu, 22 Nov 2001 18:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281820AbRKVXzk>; Thu, 22 Nov 2001 18:55:40 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:26096 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281819AbRKVXzf>;
	Thu, 22 Nov 2001 18:55:35 -0500
Date: Thu, 22 Nov 2001 16:54:54 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Rich Baum <richbaum@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix compile warnings in 2.4.15pre9
Message-ID: <20011122165454.P1308@lynx.no>
Mail-Followup-To: Rich Baum <richbaum@acm.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <132A4694022@coral.indstate.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <132A4694022@coral.indstate.edu>; from richbaum@acm.org on Thu, Nov 22, 2001 at 05:45:23PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 22, 2001  17:45 -0500, Rich Baum wrote:
How about something like (not real patches, but you get the idea:

@@ -4691,6 +4691,7 @@
 	OUTL_DSP (SCRIPTA_BA (np, clrack));
+out_stuck:
 	return;
-out_stuck:
 }
 
@@ -5226,6 +5227,7 @@
 
+fail:
 	return;
-fail:
 }
 
Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

