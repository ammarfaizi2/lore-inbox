Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313019AbSDKXdW>; Thu, 11 Apr 2002 19:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313022AbSDKXdV>; Thu, 11 Apr 2002 19:33:21 -0400
Received: from mail.lmcg.wisc.edu ([144.92.101.145]:14723 "EHLO
	mail.lmcg.wisc.edu") by vger.kernel.org with ESMTP
	id <S313019AbSDKXdV>; Thu, 11 Apr 2002 19:33:21 -0400
Date: Thu, 11 Apr 2002 18:33:20 -0500 (CDT)
Message-Id: <200204112333.SAA22343@radium.lmcg.wisc.edu>
From: Daniel Forrest <forrest@lmcg.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: lockd hanging
Reply-to: Daniel Forrest <forrest@lmcg.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first post to this list, I'll try to be brief.

Kernel version 2.4.18.

Problem: under heavy load (i.e. >32 client machines locking/unlocking
the same NFS mounted file repeatedly) lockd hangs (sometimes hanging
the local file system with it) and the server must be rebooted.

I have discovered a basic flaw in the lockd code and have patched it
to work correctly.  Is there an individual who is "responsible" for
the lockd code whom I can correspond with to discuss the flaws I
have found, the solutions I have devised, and how to get this patch
into general circulation.

P.S. I have examined the lockd code up to version 2.5.7 and it has not
     changed in any significant way since 2.4.18.

-- 
+----------------------------------+----------------------------------+
| Daniel K. Forrest                | Laboratory for Molecular and     |
| forrest@lmcg.wisc.edu            | Computational Genomics           |
| (608)262-9479                    | University of Wisconsin, Madison |
+----------------------------------+----------------------------------+
