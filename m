Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.com) by vger.kernel.org via listexpand
	id <S261179AbRELFCZ>; Sat, 12 May 2001 01:02:25 -0400
Received: (majordomo@vger.kernel.com) by vger.kernel.org
	id <S261180AbRELFCP>; Sat, 12 May 2001 01:02:15 -0400
Received: from geos.coastside.net ([207.213.212.4]:32444 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261179AbRELFB4>; Sat, 12 May 2001 01:01:56 -0400
Mime-Version: 1.0
Message-Id: <p05100302b7226d91e632@[207.213.214.37]>
Date: Fri, 11 May 2001 22:01:50 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: ENOIOCTLCMD?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can somebody explain the use of ENOIOCTLCMD? There are order of 170 
uses in the kernel, but I don't see any guidelines for that use (nor 
what prevents it from being seen by user programs).

Thanks.

errno.h:

>/* Should never be seen by user programs */
>#define ERESTARTSYS	512
>#define ERESTARTNOINTR	513
>#define ERESTARTNOHAND	514	/* restart if no handler.. */
>#define ENOIOCTLCMD	515	/* No ioctl command */

-- 
/Jonathan Lundell.
