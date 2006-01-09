Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWAII5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWAII5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 03:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWAII5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 03:57:51 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:64369 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751067AbWAII5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 03:57:50 -0500
Date: Mon, 9 Jan 2006 00:54:30 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Greg KH <greg@kroah.com>, Adrian Bunk <bunk@stusta.de>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git2: CONFIGFS_FS shows up as M/y choice, help says "if unsure, say N"
Message-ID: <20060109085430.GG18439@ca-server1.us.oracle.com>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Greg KH <greg@kroah.com>, Adrian Bunk <bunk@stusta.de>,
	Alessandro Suardi <alessandro.suardi@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com> <20060106223032.GZ18439@ca-server1.us.oracle.com> <20060107220959.GA3774@stusta.de> <20060108021630.GA3771@kroah.com> <Pine.LNX.4.61.0601081247150.30148@yvahk01.tjqt.qr> <20060108162743.GA27234@kroah.com> <Pine.LNX.4.61.0601082029030.15902@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601082029030.15902@yvahk01.tjqt.qr>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 08:29:43PM +0100, Jan Engelhardt wrote:
> Well ok. What I mean is: I don't want to have configfs if I do not also 
> want ocfs2.

	While I can see where you are coming from, there are other
projects (not in-tree yet) that use configfs that may not use ocfs2.
Red Hat's cluster stuff plays with it, I think CKRM has as well.  They
need the ability to select it without selecting ocfs2, and they are
definitely not EMBEDDED.
	Is there any other way we can satisfy this?

Joel

-- 

"Maybe the time has drawn the faces I recall.
 But things in this life change very slowly,
 If they ever change at all."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
