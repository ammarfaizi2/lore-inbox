Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318188AbSHZSDa>; Mon, 26 Aug 2002 14:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318190AbSHZSD3>; Mon, 26 Aug 2002 14:03:29 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:11273 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318188AbSHZSD2>;
	Mon, 26 Aug 2002 14:03:28 -0400
Date: Mon, 26 Aug 2002 11:07:30 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Linux-usb-users@lists.sourceforge.net
Subject: [ANNOUNCE] 2002-08-26 release of hotplug scripts
Message-ID: <20020826180730.GA18536@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've just packaged up the latest Linux hotplug scripts into a release,
which can be found at:
 	http://sourceforge.net/project/showfiles.php?group_id=3D17679

Or from your favorite kernel.org mirror at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2002_08-26.tar.gz

I've also packaged up a Red Hat 7.3 based rpm:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2002_08-26-1.noarch.rpm
=20
The source rpm is available if you want to rebuild it for other distros
at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2002_08_26-1.src.rpm

The main web site for the linux-hotplug project can be found at:
	http://linux-hotplug.sf.net/
which contains lots of documentation on the whole linux-hotplug
process.  There are also links to kernel patches, not currently in the
main kernel tree, that provide hotplug functionality to new subsystems
(like CPU, SCSI, Memory, etc.)
=20
The main changes in this release are the following:
	- fix for USB hotplugging to search /etc/hotplug/usb/*.usermap

Here's the changes (and who made them) from the last release:
    Changes from David Brownell
        - load_drivers(): variables are local, and doesn't try
          usbmodules unless the $DEVICE file exists (it'd fail)
        - update hotplug.8 manpage to mention Max'patch
        - patch from Max Krasnyanskiy, now  usb hotplugging also
          searches /etc/hotplug/usb/*.usermap

   Changes from Fumitoshi UKAI
        - etc/hotplug/hotplug.functions: grep -q redirect to /dev/null=20
          closes: debian Bug#145484

thanks,

greg k-h

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9am5hMUfUDdst+ykRAnJsAJ9ka5AdXSBq+uapJzMkdXsI/H16lwCfTvpi
lL/C0u4kP6Ne5/WzcCIjLGA=
=NUrR
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
