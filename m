Return-Path: <linux-kernel-owner+willy=40w.ods.org-S448656AbUKBHo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S448656AbUKBHo0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 02:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S506449AbUKBHoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 02:44:25 -0500
Received: from nabe.tequila.jp ([211.14.136.221]:28323 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S288371AbUKBHnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 02:43:47 -0500
Message-ID: <41873A9E.3020909@tequila.co.jp>
Date: Tue, 02 Nov 2004 16:43:26 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.3) Gecko/20040917 Thunderbird/0.8 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@nosferatu.za.org>
CC: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net
Subject: Re: XMMS (or some other audio player) 'hang' issues with intel8x0
 and	dmix plugin [u]
References: <1099284142.11924.17.camel@nosferatu.lan>
In-Reply-To: <1099284142.11924.17.camel@nosferatu.lan>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/01/2004 01:42 PM, Martin Schlemmer [c] wrote:
| Hi,
|
| I have mailed below to alsa-user a time or two already, but no
| response as of yet, so I am wondering if anybody here have had
| similar issues.  Not much has changed, but I have also tried
| BMP, and alsa-player, with similar results.
|
| -----------
|
| I have a Asus P4C800-E with a SoundMax 1985 audio chip on.
| Alsa-lib-1.0.[56] and 2.6.[6789] kernel.  I have dmix setup (.asoundrc
| below).
|
| Now I mostly use XMMS for playing mp3's, and intermittently xmms
| will just 'hang'.  It is not locked or anything, but the 'graph'
| just stand still, and no audio.  If I press play again, it starts
| to play for some time again.  This is especially easy to duplicate
| if the box is under heavy load.  If I use the device directly,
| without the dmix plugin, it works fine, or if I use oss emulation,
| it works fine as well ...

I have the same problem at home, I changed something in the .asoundrc
and it went away. it still plays a little bit skippy, but better than
suddenly stop.

I had this problem on a Sony Laptop (GRX series) with an i8x0 chipsetz
and a yamaha soundchip (which is controlled by the i8x0 drivers).

I can give more info if needed.

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBhzqdjBz/yQjBxz8RAit3AKCZy9/EHC1h3xDw4Vhxshl47WfulwCfYAJf
W6PgGSyS5O0g9vMa/KNtuzU=
=uFSF
-----END PGP SIGNATURE-----
