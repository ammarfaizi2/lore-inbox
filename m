Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271205AbTHCPbk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 11:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271204AbTHCPbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 11:31:39 -0400
Received: from [24.241.190.29] ([24.241.190.29]:12673 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S271205AbTHCPbh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 11:31:37 -0400
Date: Sun, 3 Aug 2003 11:31:36 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: USB Disk (Archos Jukebox) and 2.6.0-test2 (-mm3)
Message-ID: <20030803153136.GA691@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Since 2.6.0 and on I've had problems with mounting up my Archos Jukebox
MP3 player.  In the 2.4.20 kernel I used to:

Power on the unit
plug in the USB cable
modprobe usb-storage
  (scsi disk is compiled in)
mount /dev/sda1


Debian Unstable
{1}:/home/nomad>lspci -v | grep -i usb
00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 05) (prog-if 00 [UHCI])
00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 05) (prog-if 00 [UHCI])

"hotplug" autoloads the module for my visor and it is working properly.
When I plug in archos it sees a device but says there's no module for
the device.

Now when I modprobe usb-storage it hangs the shell and pretty much the
machine.  No real output, it just sits there.  I've had this same
behavior in 2.6.0-test1, test2 and test2-mm3.

If someone wishes to give me some debug commands to run or alternate
compile options feel free.

Robert


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/LSrY8+1vMONE2jsRAkudAKCrt0othxxt5WI0iNb6lWb5pqEZcQCfZSum
c3HAHaXDyg6HYbmKrFXKcXs=
=FZnv
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
