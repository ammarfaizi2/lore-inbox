Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273018AbRIISqE>; Sun, 9 Sep 2001 14:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273016AbRIISpy>; Sun, 9 Sep 2001 14:45:54 -0400
Received: from static004-9-151-24.nt02-c4.cpe.charter-ne.com ([24.151.9.4]:7700
	"EHLO Jupiter.LIWAVE.COM") by vger.kernel.org with ESMTP
	id <S273014AbRIISpg>; Sun, 9 Sep 2001 14:45:36 -0400
Reply-To: <rvandam@liwave.com>
From: "Ron Van Dam" <rvandam@liwave.com>
To: <linux-kernel@vger.kernel.org>
Cc: <rvandam@liwave.com>
Subject: FW: OT: Integrating Directory Services for Linux
Date: Sun, 9 Sep 2001 14:45:44 -0400
Message-ID: <001001c1395f$a246cd70$1f0201c0@w2k001>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IMHO, directory services for managing user accounts and permissions for
linux is pretty dismal at this point. I know there are userland projects
available for linux such as PAM and OpenLDAP, but they are relatively hard
to set up and get working and fall short on delivery. If anyone has worked
with Novell's NDS and tried emulate it with OpenLDAP and PAM you know what I
mean.

Has anyone thought much about integrating DS for Linux. I thought it would
be a real good idea to have a DS architecture built-in to linux to manage
just about everything, from user accounts, service configuration parameters,
mounts, kernel-modules, to function call security permissions. Having this
level of functionally would be a significant improvement for the
administrator who manages a large number of servers, especially for managing
Linux for Desktop users.

I know some one out there is comparing this concept to the Windows registry.
I was thinking that this would be a distributed database with journalling,
with all of the checks of a filesystem to protect the database. The database
would also need to be extensible so that userland developers can import
schema to extend the functionally of the database. For instance, the
database could be used to manage a DHCP or DNS server, or  storing your user
profile (.gnome or .kde) configurations. It should also support partitioning
if I have multiple sites connected by a WAN, I can partition the database
information so that only the essential information is replicated between
sites and the WAN isn't clogged with replication traffic.


Comments?


Thanks for reading this
Ron

