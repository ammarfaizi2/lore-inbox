Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265796AbTF3I64 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 04:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbTF3I64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 04:58:56 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:64450 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265796AbTF3I6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 04:58:54 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16127.65320.935208.584846@laputa.namesys.com>
Date: Mon, 30 Jun 2003 13:13:12 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File System conversion -- ideas
In-Reply-To: <20030629202509.GJ27348@parcelfarce.linux.theplanet.co.uk>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk>
	<20030629132807.GA25170@mail.jlokier.co.uk>
	<3EFEEF8F.7050607@post.pl>
	<20030629192847.GB26258@mail.jlokier.co.uk>
	<20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk>
	<200306291545410600.02136814@smtp.comcast.net>
	<20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.55.0306291317300.14949@bigblue.dev.mcafeelabs.com>
	<20030629202509.GJ27348@parcelfarce.linux.theplanet.co.uk>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
X-Zippy-Says: It's 74 degrees, 12 minutes NORTH, and 41 degrees, 3 minutes EAST!!
   Soon, it will be TUESDAY!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk writes:
 > On Sun, Jun 29, 2003 at 01:19:24PM -0700, Davide Libenzi wrote:
 > 
 > > > AFAICS, it is _very_ hard to implement.  Even outside of the kernel.
 > > > If you can get it done - well, that might do a lot for having the
 > > > idea considered seriously.  "Might" since you need to do it in a way
 > > > that would survive transplantation into the kernel _and_ would scale
 > > > better that O((number of filesystem types)^2).
 > > 
 > > Maybe defining a "neutral" metadata export/import might help in limiting
 > > such NFS^2 ...
 > 
 > Go for it - do it in userland, define the mapping between various sorts
 > of metadata and let's see how well you can make it work.  Have fun.

Some people are actually doing this:

http://tzukanov.narod.ru/convertfs/

 > -

Nikita.
