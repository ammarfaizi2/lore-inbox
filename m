Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314061AbSEFBwE>; Sun, 5 May 2002 21:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314065AbSEFBwD>; Sun, 5 May 2002 21:52:03 -0400
Received: from c-24-98-8-129.atl.client2.attbi.com ([24.98.8.129]:65288 "EHLO
	c-24-98-8-129.atl.client2.attbi.com") by vger.kernel.org with ESMTP
	id <S314061AbSEFBwC>; Sun, 5 May 2002 21:52:02 -0400
Subject: [Patch] SiS 740/961 chipset
From: Blue Lizard <webmaster@dofty.zzn.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-q0ZVlti2gvFXW+4bU9SX"
X-Mailer: Ximian Evolution 1.0.3 
Date: 05 May 2002 21:52:29 -0400
Message-Id: <1020649949.12612.13.camel@c-24-98-8-129.atl.client2.attbi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q0ZVlti2gvFXW+4bU9SX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Greets.  I made a very simple 2 line (plain english and all) patch for
pci.ids to support the SiS 740/961 chipset.  AFAICT it works, given that
the patched kernel can now detect my pci devices (unpatched can't).
The patch is against 2.5.13, backporting to 2.4.19 is simply a matter of
noting the right line numbers.

Regards
-MG


--=-q0ZVlti2gvFXW+4bU9SX
Content-Disposition: attachment; filename=pci.ids.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=pci.ids.diff; charset=ISO-8859-1

856a857
> 	0740  740 Host
858a860
> 	0961  961 PCI Chip

--=-q0ZVlti2gvFXW+4bU9SX--
