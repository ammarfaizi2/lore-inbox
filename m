Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263352AbUCPQvS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbUCPQtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:49:36 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:8169 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S263352AbUCPQlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:41:12 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch/RFC] networking menus
Date: Tue, 16 Mar 2004 12:01:13 +0100
User-Agent: KMail/1.6
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, niv@us.ibm.com,
       benh@kernel.crashing.org, davem@redhat.com, netdev@oss.sgi.com
References: <20040314163327.53102f46.rddunlap@osdl.org> <20040314190724.1af1f11d.rddunlap@osdl.org> <20040314205438.3d7bcd34.rddunlap@osdl.org>
In-Reply-To: <20040314205438.3d7bcd34.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403161201.15427.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On Monday 15 March 2004 05:54, Randy.Dunlap wrote:
> Does it make sense to anyone besides me to move protocol-related
> modules like SLIP, PPP, and PLIP from Device Drivers/Network device(s)
> to "Networking support"?
> They feel more like protocols than device drivers to me....

Or just create sth. like:

Stacks
	+- IPv6
	+- LLC
	+- IrDA
	+- Bluetooth

Protocols
	+- PPP
	+- SLIP
	+- ...

Routing
	+- Multicast
	+- Advanced router

Filtering
Devices

Or similiar

Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAVt55U56oYWuOrkARAvGBAKCFh9DMVaKSlnj+X0CFuNFYgAc3CwCgv1vs
uet2gOmSQSwXJSo7hjpes2s=
=LfML
-----END PGP SIGNATURE-----
