Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268985AbVBFA5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268985AbVBFA5F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268970AbVBFA5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:57:03 -0500
Received: from smtpout.mac.com ([17.250.248.89]:59867 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S268924AbVBFA42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:56:28 -0500
In-Reply-To: <Pine.LNX.3.96.1050206010842.16513A-100000@pioneer.space.nemesis.pl>
References: <Pine.LNX.3.96.1050206010842.16513A-100000@pioneer.space.nemesis.pl>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DE2864CA-77D9-11D9-BD1C-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Otto Wyss <otto.wyss@orpatec.ch>, Marko Macek <Marko.Macek@gmx.net>,
       linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [OT] Re: Why is debugging under Linux such a pain
Date: Sat, 5 Feb 2005 19:56:00 -0500
To: Tomasz Rola <rtomek@ceti.pl>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 05, 2005, at 19:23, Tomasz Rola wrote:
> On Sat, 5 Feb 2005, Marko Macek wrote:
> [...]
>> It would be nice if display lock programs used a separate X display
>> (some kind of "virtual" display support might be nice to have, mainly
>> for performance).
>
> I would try VNC for this, at least for debugging. But I don't really 
> know
> if it would have worked. My distro (Debian) has VNC packed nicely
> (vncserver and xvncviewer packages), others should have it too. So the
> trial should be rather quick if you use such Linux flavor.

You could also try Xnest, which runs a second X-server within a window 
of
the primary X-server, except without most of the extra overhead of VNC 
or
other image-based solutions. Xnest can even handle different bit-depths
than the primary display, and only slightly modifies most X calls, 
except
for the ones that affect global state, which it processes internally.


Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


