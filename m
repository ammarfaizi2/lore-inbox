Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268084AbTBYREP>; Tue, 25 Feb 2003 12:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268091AbTBYREO>; Tue, 25 Feb 2003 12:04:14 -0500
Received: from pirx.hexapodia.org ([208.42.114.113]:54415 "HELO
	pirx.hexapodia.org") by vger.kernel.org with SMTP
	id <S268084AbTBYREO>; Tue, 25 Feb 2003 12:04:14 -0500
Date: Tue, 25 Feb 2003 11:14:28 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Diksha B Bhoomi <dikshabhoomi@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Writing new filesystem
Message-ID: <20030225111428.A1666@hexapodia.org>
References: <20030225083631.17493.qmail@webmail17.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030225083631.17493.qmail@webmail17.rediffmail.com>; from dikshabhoomi@rediffmail.com on Tue, Feb 25, 2003 at 08:36:31AM -0000
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 08:36:31AM -0000, Diksha B Bhoomi wrote:
> I am interested in writing a new filesystems. For that purpose I 
> took thr src from msdos and tried to do the compiling. The 
[snip]
> new kernel but here again it does not take into account the new ly 
> added dir. I then followed to make dep. In this it goes to myfs 
> dir but no compiletion happens. It creates two files myfs.ver and 
[snip]

Look at fs/Makefile, search for "ext2", and add your new fs directory in
the appropriate spots.

I would recommend using ext2 or something, rather than msdosfs, as your
template.  The DOS filesystem is crufty.

-andy
