Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272274AbRIETNx>; Wed, 5 Sep 2001 15:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272277AbRIETNr>; Wed, 5 Sep 2001 15:13:47 -0400
Received: from host213-123-129-26.in-addr.btopenworld.com ([213.123.129.26]:41220
	"EHLO ambassador.mathewson.int") by vger.kernel.org with ESMTP
	id <S272274AbRIETMs>; Wed, 5 Sep 2001 15:12:48 -0400
Message-Id: <200109051913.f85JD2K01304@ambassador.mathewson.int>
Subject: [OFFTOPIC] Secure network fileserving Linux <-> Linux
To: linux-kernel@vger.kernel.org
From: Joseph Mathewson <joe@mathewson.co.uk>
Reply-to: joe.mathewson@btinternet.com
Date: Wed, 05 Sep 2001 20:13:02 +0100
X-Mailer: TiM infinity-ALPHA6-rc0.8-jjm
X-TiM-Client: deschutes [192.168.0.202]
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to ask another annoying question so quickly after my SCSI problems,
but

Does anyone know of/use a secure network filesharing system on a Linux
network?  We currently have a room of about 10 machines, mostly Linux
clients (some MacOS X, soon to come Sun and HP-UX boxes) and servers (all
running Linux).

For some time now, we've been using NFS for filesharing /home and have been
extremely concerned about security.  All the clients in theory run the same
uids/gids, thanks to LDAP, but that doesn't stop someone plugging in an
unauthorized machine and merrily destroying everyone's home directories.

Apparently some work was done to Kerberize various bits of NFS, and Sun
have a secure(r) implementation in Solaris.

Does anyone know of a free (preferably easy :) way of secure Linux <->
Linux filesharing?  Apologies if that seems like a flame, maybe I've missed
the obvious solution.  (Preferably a solution that doesn't involve editing
/etc/exports to only allow connections from specified IPs, because if
someone was going to go to the length of destroying our data, they could
fake that.  Similarly, MAC addresses.)

Joe.

+-------------------------------------------------+
| Joseph Mathewson <joe@mathewson.co.uk>          |
+-------------------------------------------------+
