Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbTAaPXb>; Fri, 31 Jan 2003 10:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbTAaPXb>; Fri, 31 Jan 2003 10:23:31 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:61568 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S261375AbTAaPX3>; Fri, 31 Jan 2003 10:23:29 -0500
Message-Id: <200301311532.h0VFWilH008170@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59 morse code panics 
In-Reply-To: Your message of "Fri, 31 Jan 2003 15:05:41 GMT."
             <20030131150541.GA15332@codemonkey.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20030131104326.GF12286@louise.pinerecords.com> <200301311112.h0VBCv00000575@darkstar.example.net> <20030131132221.GA12834@codemonkey.org.uk> <200301311440.h0VEeRlH005883@turing-police.cc.vt.edu>
            <20030131150541.GA15332@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_504278532P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 31 Jan 2003 10:32:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_504278532P
Content-Type: text/plain; charset=us-ascii

On Fri, 31 Jan 2003 15:05:41 GMT, Dave Jones said:

> So go see Ingo's netconsole. (Which admittedly only supports certain
> net drivers). Or one of the crashdump facilities. All of which is far more
> reliable and useful than sitting there with a microphone.

If I don't have a second box to run a serial cable to, I probably don't have
a second box to run cat5 to, so netconsole probably doesn't do me any good.

crashdump might be usable, I'll have to look...

> There's no reason to trust morse panic output more than console output.
> If something has scribbled over kernel space memory, you're screwed
> anyway. It's hit or miss whether your panic-method-de-jour has been
> stomped on.

The real solution is probably to get Ingo's netconsole, the morse-panic patch,
the current serial-console support, and abstract it all into some
infrastructure with output hooks - netconsole, serial, morse, whatever.

But we're alledgedly in a feature freeze, so that's a 2.7-ish I guess...
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_504278532P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+OpcccC3lWbTT17ARAmhuAKD4/rcPrss0sd/vLP93VoE+1Pm1qACfV9NF
J6IH/VkXfJZqKLoZWMv12dg=
=RV/B
-----END PGP SIGNATURE-----

--==_Exmh_504278532P--
