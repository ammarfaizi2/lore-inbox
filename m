Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261365AbSJUNDj>; Mon, 21 Oct 2002 09:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261367AbSJUNDj>; Mon, 21 Oct 2002 09:03:39 -0400
Received: from mta04ps.bigpond.com ([144.135.25.136]:18113 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S261365AbSJUNDi>; Mon, 21 Oct 2002 09:03:38 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: jbradford@dial.pipex.com, linux-kernel@vger.kernel.org
Subject: Re: xconfig broken in 2.5.44?
Date: Mon, 21 Oct 2002 23:01:04 +1000
User-Agent: KMail/1.4.5
References: <200210211255.g9LCt9aq004245@darkstar.example.net>
In-Reply-To: <200210211255.g9LCt9aq004245@darkstar.example.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210212301.04719.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 21 Oct 2002 22:55, jbradford@dial.pipex.com wrote:
> Maybe I'm missing something obvious, but:
Here is what I did:

diff -Naur -X dontdiff linux-2.5.44-clean/drivers/pnp/Config.in linux-2.5.44/drivers/pnp/Config.in
- --- linux-2.5.44-clean/drivers/pnp/Config.in    2002-10-19 14:01:07.000000000 +1000
+++ linux-2.5.44/drivers/pnp/Config.in  2002-10-21 22:59:50.000000000 +1000
@@ -4,7 +4,7 @@
 mainmenu_option next_comment
 comment 'Plug and Play configuration'

- -dep_bool 'Plug and Play support' CONFIG_PNP
+bool 'Plug and Play support' CONFIG_PNP

    dep_bool '  Plug and Play device name database' CONFIG_PNP_NAMES $CONFIG_PNP
    dep_bool '  PnP Debug Messages' CONFIG_PNP_DEBUG $CONFIG_PNP

- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9s/qQW6pHgIdAuOMRAkDrAKCfYYDhcCBNZFRAip1mvxnWkpoUHACgtUuq
HNzML3G7tpgj3sW807a1WEw=
=Ptzi
-----END PGP SIGNATURE-----

