Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136536AbREDWNy>; Fri, 4 May 2001 18:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136537AbREDWNo>; Fri, 4 May 2001 18:13:44 -0400
Received: from adsl-216-63-56-125.dsl.stlsmo.swbell.net ([216.63.56.125]:57098
	"EHLO dublin.innovates.com") by vger.kernel.org with ESMTP
	id <S136536AbREDWN0>; Fri, 4 May 2001 18:13:26 -0400
X-OpenMail-Hops: 1
Date: Fri, 4 May 2001 17:16:22 -0500
Message-Id: <H00000650007236c.0989014582.dublin.innovates.com@MHS>
Subject: Setting kernel options at compile time.
MIME-Version: 1.0
From: (Chip Schweiss) chip@innovates.com
TO: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline; filename="BDY.TXT"
	;Creation-Date="Fri, 4 May 2001 17:16:22 -0500"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get a 2.2.19 kernel loaded on an i810 system using RPLD on 
a diskless system.  I can get the kernel loaded and running.  The 
problem is the i810 needs the kernel parameter "mem=xxxM" set to tell 
the kernel how much memory the system has since the on the i810 the 
kernel doesn't know how much was taken for video.

The catch I'm running into is RPLD cannot pass parameters to the kernel 
and without this setting the system has video problem, most likely from 
the memory sharing issues.  When the mem parameter is set when using a 
disk it doesn't demonstrate any problems.

What I'm trying to figure out is how to compile in this setting.

Thanks,
Chip Schweiss
 

