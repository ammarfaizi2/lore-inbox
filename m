Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbUCHWpQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbUCHWpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:45:15 -0500
Received: from fep21-0.kolumbus.fi ([193.229.0.48]:43752 "EHLO
	fep21-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261390AbUCHWpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:45:03 -0500
Message-ID: <404CF77A.2050301@helsinki.fi>
Date: Tue, 09 Mar 2004 00:45:14 +0200
From: Kliment Yanev <Kliment.Yanev@helsinki.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Nokia c110 driver
References: <40408852.8040608@helsinki.fi>	<20040228104105.5a699d32.rddunlap@osdl.org>	<40419A1C.5070103@helsinki.fi>	<20040301101706.3a606d35.rddunlap@osdl.org>	<404C8A35.3020308@helsinki.fi> <20040308090640.2d557f9e.rddunlap@osdl.org>
In-Reply-To: <20040308090640.2d557f9e.rddunlap@osdl.org>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Randy.Dunlap wrote:

| |
| | I compared the orinoco_cs drivers in 2.4 and 2.6 and I updated the nokia
| | driver source. However now I get "-1 unknown symbol in module" when I
| | try to insmod the module... where should I start troubleshooting?
|
| Set the console loglevel to 9 so that you can see all of the
| kernel messages and then try to reload the module.  Some explanatory
| error message should appear to indicate the problem area.
|

dmesg handled that. dmesg output below (there was also an
"unknown symbol CardServices" but I fixed that bu replacing all
references to CardServices with the pcmcia_functionname functions.
What are the replacements for these then? (The license string I can
correct myself)

nokia_c110: module license 'unspecified' taints kernel.
nokia_c110: Unknown symbol dcfg_new
nokia_c110: Unknown symbol dllc_register
nokia_c110: Unknown symbol dllc_delete
nokia_c110: Unknown symbol dfree
nokia_c110: Unknown symbol ddev_register
nokia_c110: Unknown symbol dmgr_pcmcia_action
nokia_c110: Unknown symbol dcfg_delete
nokia_c110: Unknown symbol dmgr_new
nokia_c110: Unknown symbol dllc_new
nokia_c110: Unknown symbol dprintk
nokia_c110: Unknown symbol dllc_set_my_mac_addr
nokia_c110: Unknown symbol dmgr_delete
nokia_c110: Unknown symbol ddev_unregister
nokia_c110: Unknown symbol dhw_get_my_mac
nokia_c110: Unknown symbol dhw_delete
nokia_c110: Unknown symbol dhw_new
nokia_c110: Unknown symbol dhw_ISR
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFATPd5rPQTyNB9u9YRAogGAJ4rJ/1b/jYIV9cVoMNtxHcSLWJAFgCfSHRx
yWUBscVlvQKL/xdQ1biVXK4=
=ezLe
-----END PGP SIGNATURE-----
