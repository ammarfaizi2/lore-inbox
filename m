Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266718AbTAUJE0>; Tue, 21 Jan 2003 04:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266809AbTAUJEZ>; Tue, 21 Jan 2003 04:04:25 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:11950 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266718AbTAUJEZ>; Tue, 21 Jan 2003 04:04:25 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15917.3895.100193.906443@laputa.namesys.com>
Date: Tue, 21 Jan 2003 12:13:27 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: linux-kernel@vger.kernel.org
Cc: folkert@vanheusden.com, Rik van Riel <riel@conectiva.com.br>
Subject: Re: tool for testing how fast your kernel can rename files :-)
In-Reply-To: <Pine.LNX.4.50L.0301202342390.18171-100000@imladris.surriel.com>
References: <Pine.LNX.4.33.0301201826120.13207-100000@muur.intranet.vanheusden.com>
	<Pine.LNX.4.50L.0301202342390.18171-100000@imladris.surriel.com>
X-Mailer: VM 7.07 under 21.5  (beta9) "brussels sprouts" XEmacs Lucid
X-NSA-Fodder: radar David John Oates Ron Brown clones White Water SEAL Team 6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
 > On Mon, 20 Jan 2003 folkert@vanheusden.com wrote:
 > 
 > > This night, while half a-sleep I thought it is usefull to have a tool
 > > which creates a number of files in a directory and then starts to
 > > randomly rename them.
 > 
 > > But now, fully awake with at least 8 cups of coffee in my system I cannot
 > > think of anything usefull this program is actually doing.
 > > Well, maybe to test if something gets corrupted allong the way?
 > 
 > You could test with NFS, you might even break something...

Now, when NFS has been mentioned.

To test reiser{fs,4} we use
ftp://ftp.namesys.com/pub/namesys-utils/nfs_fh_stale.c which creates
given number of threads each performing randomly reads, writes,
truncates, renames, fsyncs, and unlinks over the shared set of files. As
its name implies it was initially created to test support for the stale
NFS handle detection, but turned out to be quite useful for the general
testing also.

 > 
 > Rik

Nikita.
