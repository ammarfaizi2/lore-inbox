Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbTEMCLW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 22:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbTEMCLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 22:11:22 -0400
Received: from smtp1.cwidc.net ([154.33.63.111]:31655 "EHLO smtp1.cwidc.net")
	by vger.kernel.org with ESMTP id S262563AbTEMCLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 22:11:21 -0400
Message-ID: <3EC05746.1070307@tequila.co.jp>
Date: Tue, 13 May 2003 11:24:06 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030506
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anders Karlsson <anders@trudheim.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Two RAID1 mirrors are faster than three
References: <200305112212_MC3-1-386B-32BF@compuserve.com>	 <3EBF24A8.1050100@tequila.co.jp>	 <1052716203.4100.10.camel@tor.trudheim.com>	 <3EBF5DF2.2080204@tequila.co.jp> <1052731825.3522.23.camel@tor.trudheim.com>
In-Reply-To: <1052731825.3522.23.camel@tor.trudheim.com>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Anders Karlsson wrote:

> On Mon, 2003-05-12 at 09:40, Clemens Schwaighofer wrote:
 >
> I think it depends greatly on your needs. For small companies running
> commercial unices, this might be the best solution based upon need and
> cost. For even smaller outfits running Linux, the snapshot feature in
> Linux LVM will do the job.

well, for private yes, but even as a small company I would invest in a
rother more solid hardware RAID system than into software. I saw so many
horrible data losses due software raid or IDE HDs (which where in a
external hardware box actually), that I don't trust this much anymore.

> Then there is the issue of people that are just simple ultra-paranoid
> about their data or where the 2nd copy is in fact off-site (using SCSI
> extenders).

well I always had a hot spare HD in my boxes because I was a bit
ultra-paranoid, actually I became ultra-paranoid :)

>>I can only image a Hotspare Disc, thats all.

> In the tradition of Unix, there are more than one way to skin a cat. ;-)

there is for Software, but when it comes to Hardware security, I trust
in real RAID (unless it is private adventures)

- --
Clemens Schwaighofer - IT Engineer & System Administration
==========================================================
Tequila Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
http://www.tequila.jp
==========================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+wFdFjBz/yQjBxz8RAjucAJwNYqxZKkwZOUiNlc7v3Fxf3y+/RACfRo2S
CNs6Ln3nALc7WUg+MGMlbkc=
=2syv
-----END PGP SIGNATURE-----

