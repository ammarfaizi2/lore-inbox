Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbUBVQXg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 11:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbUBVQXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 11:23:36 -0500
Received: from h196n1fls22o974.bredband.comhem.se ([213.64.79.196]:64917 "EHLO
	latitude.mynet.no-ip.org") by vger.kernel.org with ESMTP
	id S261688AbUBVQXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 11:23:31 -0500
X-Mailer: exmh version 2.6.3 04/02/2003 with nmh-1.0.4
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Simon Gate <simon@noir.se>, linux-kernel@vger.kernel.org
Subject: Re: psmouse.c: Mouse at isa0060/serio1/input0 lost 
 synchronization, throwing 2 bytes away.
In-Reply-To: Message from Vojtech Pavlik <vojtech@suse.cz> 
   of "Sun, 15 Feb 2004 09:06:10 +0100." <20040215080610.GA314@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Feb 2004 17:23:24 +0100
From: aeriksson@fastmail.fm
Message-Id: <20040222162325.4F3FF3F04@latitude.mynet.no-ip.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Sat, Feb 14, 2004 at 10:43:48PM +0100, Simon Gate wrote:
> > Changed from kernel 2.6.1 to 2.6.2 an get this error in dmesg
> > 
> > psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 
> bytes away.
> > 
> > My mouse goes crazy for a few secs and then returns to normal for a while. 
> Is this a 2.6.2 problem or is this is something old?
> 
> It's a 2.6.2 bug and fixed in 2.6.3-rc1.
> 

Just switched to 2.6.3 and I can report that this misbehavior is still
there. Not quite as frequent as before (just a feeling). There seems
to be another failure mode introduced now. At time it just freezes for
about 1-3 seconds. I.e. The mouse just don't respond to anything. The
crazy movements are the more common failure mode though.

Anyone else recognize this? I get the infamous "psmouse.c: Wheel Mouse
at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away."
thing still...

suggestions are welcome...

/Anders


