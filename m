Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262672AbSI1BSQ>; Fri, 27 Sep 2002 21:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262673AbSI1BSP>; Fri, 27 Sep 2002 21:18:15 -0400
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:27200 "HELO
	laura.worldcontrol.com") by vger.kernel.org with SMTP
	id <S262672AbSI1BSN>; Fri, 27 Sep 2002 21:18:13 -0400
From: brian@parcoursesoftware.com
Date: Fri, 27 Sep 2002 18:23:31 -0700
To: linux-kernel@vger.kernel.org
Subject: SWSUSP and occasional keyboard/X locks (not GPM)
Message-ID: <20020928012331.GA2625@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running 2.4.18 vanilla with swsusp patches.  I've disabled GPM
and suspend/resume works well.

However, occasionally when my laptop resumes everything appears ok,
but the keyboard and mouse (touchpad) don't respond.   If I ssh
in via the ethernet I can kill X and keyboard control comes back.
(this is the same behavior I saw with GPM was missing things up)
(I've actually removed the gpm executable from my machine)

I use the 'susp' script to suspend the machine which knocks out most
of the known problems with software suspend.

I'm running XFree86 4.2.1.

My laptop is a Sony VAIO FXA32 w/Duron 900MHz and 384MB RAM.

You can have a look at the susp script at

    http://www.litzinger.com/susp

Any ideas?

-- 
Brian Litzinger

 FREE Bug & Support Tracking tool http://www.ParcourseSoftware.com
 SFA, CRM, HelpDesk, Engineering: Small Company to Multi-National Enterprise
 Crossplatform: MS Windows, Linux, Solaris, Macintosh, mix & match
