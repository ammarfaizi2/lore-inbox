Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287946AbSBIBKl>; Fri, 8 Feb 2002 20:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287979AbSBIBK2>; Fri, 8 Feb 2002 20:10:28 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:61369 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP
	id <S287946AbSBIBKV>; Fri, 8 Feb 2002 20:10:21 -0500
Date: Fri, 8 Feb 2002 20:07:59 -0500
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: de_put: entry sys already free!
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020209011023.UBOE29231.out007.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Just an FYI, I've received this syslog message twice now with
2.5.4-pre3:  'de_put: entry sys already free!'.

It seems to be harmless, but I'd thought I'd post it.  It's just a
procfs error message, but maybe somebody out there has a clue why it's
being generated (aside from what the message says).

It's coming from de_put in fs/proc/inode.c

- -- 
Skip  ID: 0x7EDDDB0A
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAjxkdjQACgkQBMKxVH7d2wpvFQCeLAKzhOflfnbjsB/LYXp2nE2D
Tk0AoNA5/BXNPzrMdUW2n5dCCLqUmnu3
=7U11
-----END PGP SIGNATURE-----
