Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265690AbSKFPL3>; Wed, 6 Nov 2002 10:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbSKFPL3>; Wed, 6 Nov 2002 10:11:29 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:34260 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S265690AbSKFPL2>;
	Wed, 6 Nov 2002 10:11:28 -0500
Subject: Re: yet another update to the post-halloween doc.
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021106140844.GA5463@suse.de>
References: <20021106140844.GA5463@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Nov 2002 16:18:04 +0100
Message-Id: <1036595884.20312.21.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 15:08, Dave Jones wrote:

> Need checking.
> ~~~~~~~~~~~~~~
> - Someone reported evolution locks up when calender/tasks/contacts is selected.
>   http://lists.ximian.com/archives/public/evolution-hackers/2002-March/004292.html
>   reports this as an evolution/ORBit problem.  Did it get fixed ?

I found this in Michael Meeks activitylog
(http://www.gnome.org/~michael/activity.html):

2002-10-31: It looks like Ronald Kuetemeier located the problem with
ORBit-0.5 causing problems for evolution on the 2.5 kernel series, a
change in getpeername behavior - good man.

This is what I found:

thread:
http://lists.ximian.com/archives/public/evolution-hackers/2002-October/005193.html

patch to orbit:
http://lists.ximian.com/archives/public/evolution-hackers/2002-October/005218.html

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat
you with experience.
