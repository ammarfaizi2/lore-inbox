Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280051AbRKITVj>; Fri, 9 Nov 2001 14:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280056AbRKITVW>; Fri, 9 Nov 2001 14:21:22 -0500
Received: from [63.164.206.11] ([63.164.206.11]:24580 "EHLO
	message.ucentric.com") by vger.kernel.org with ESMTP
	id <S280043AbRKITUy>; Fri, 9 Nov 2001 14:20:54 -0500
Message-ID: <3BEC39E6.7F0FA75F@ucentric.com>
Date: Fri, 09 Nov 2001 15:17:42 -0500
From: paulh@ucentric.com
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: The page cache keeps growing
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to throw this out to the group for opinions-

I'm working on a box using the 2.4.9 kernel that is saving a couple of
mpeg2
video streams, while playing back one of them.  The box also allows one
to
web browse, play mp3's and configure one's home network.

What I'm seeing is the page cache grow to huge sizes- to as much as
102MB
of 128MB of memory.  This is causing pages to be stolen from other
processes
in memory, so that when a user attempts to go to one of these, a long
wait ensues
while it's paged back in.

Is there any way to limit page cache size?  I've looked over the mm code
and
nothing pops out.  Has someone written a patch to do this?  I've checked
some
archives but have come up empty handed.

Thanks,
paulh

--
Paul Hansen, Software Engineer           paulh@ucentric.com
Ucentric Systems LLC                     Phone 978.823.8157
2 Clocktower Place, Suite 550            FAX   978.823.8101
Maynard, MA 01754                        www.ucentric.com



