Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132224AbQL1WHg>; Thu, 28 Dec 2000 17:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132220AbQL1WH0>; Thu, 28 Dec 2000 17:07:26 -0500
Received: from wpk-smtp-relay2.cwci.net ([195.44.63.19]:53787 "EHLO
	wpk-smtp-relay.cwci.net") by vger.kernel.org with ESMTP
	id <S131955AbQL1WHV>; Thu, 28 Dec 2000 17:07:21 -0500
Date: Thu, 28 Dec 2000 21:36:07 +0000 (UTC)
From: Mo McKinlay <mmckinlay@gnu.org>
X-X-Sender: <mckinlay@kyle.altai.org>
To: Ari Heitner <aheitner@andrew.cmu.edu>
cc: Chris Wedgwood <cw@f00f.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <Pine.SOL.3.96L.1001228000150.3482A-100000@unix13.andrew.cmu.edu>
Message-ID: <Pine.LNX.4.31.0012282135270.1333-100000@kyle.altai.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


  > does anyone other than me think that the pm code is *way* too agressive about
  > spinning down the hard drive? my 256mb laptop (2.2.16) will only spin down the
  > disk for about 30 seconds before it decides it's got something else it feels
  > like writing out, and spins back up. Spinnup has got to be more wasteful than
  > just leaving the drive spinning...

Yup, I find this - especially if I hang around in X for a while.

- -- 
"""""  "" " " " " " " "  "  """   "   "     " " "" "       "
  "" "    ""  """ ""  "  "  "      "  "" "       """  """ "
""   ""   """ " " """ "  "   "    "     """    " ""  "       ""
"" """" "  "  "    "        " "       """"     " "   """" "  ""
        "   "  "    ""  " "   "  ""   """"     " "   """" "  ""


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Made with pgp4pine

iD8DBQE6S7JJRcGgB3aidfkRAhpkAJ9UYVhD+sRqADqUMm2i+UgbuYS8kACgzG4E
WhqPEhm6XHixqHpUOFQ4els=
=yQKY
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
