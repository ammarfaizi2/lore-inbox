Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286424AbRLTW3i>; Thu, 20 Dec 2001 17:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286422AbRLTW33>; Thu, 20 Dec 2001 17:29:29 -0500
Received: from moremagic.merlins.org ([204.80.101.251]:14222 "EHLO
	mail2.merlins.org") by vger.kernel.org with ESMTP
	id <S286421AbRLTW3T>; Thu, 20 Dec 2001 17:29:19 -0500
Date: Thu, 20 Dec 2001 14:29:17 -0800
From: Marc MERLIN <marc_ln@merlins.org>
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP stall between 2.4.14-patched and Win XP ?
Message-ID: <20011220142917.A8914@merlins.org>
In-Reply-To: <20011220130530.Q16402@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20011220130530.Q16402@merlins.org>; from marc_ln@merlins.org on Thu, Dec 20, 2001 at 01:05:30PM -0800
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-Operating-System: Proudly running Linux 2.4.14-lvm1.0.1rc4-ext3-0.9.15-grsec-1.8.8-servers11/Debian woody
X-Mailer: Some Outlooks can't quote properly without this header
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 01:05:30PM -0800, Marc MERLIN wrote:
> The XP  machine connects to  the linux box, packets  go back and  forth, and
> when the linux machine starts pushing a  lot of data back, XP lowers the TCP
> window until the connection stalls.

I should have added more details here.
I know  this looks like a  classic issue of  the client app not  reading its
data (netscape mail polling mail over imap in this case).
It's just that the same exact app  was working fine on the same mail folders
on  non XP  machines, and the same netscape had no issues polling mail from
other servers,  so I started suspecting  something on the TCP  layer between
the two OSes

Mika  Liljeberg sent  me a  mail confirming  that it  really looks  like the
client app  not reading its data. Of  course, I can strace  the imap server,
but I don't know how to do that with netscape on XP :-)

Either way, although I can't confirm  it for now, I'll assume that something
weird is  happening with the app,  and that it's indeed  responsible for the
stall.

Sorry for the noise.
Marc
-- 
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
  
Home page: http://marc.merlins.org/   |   Finger marc_f@merlins.org for PGP key
