Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTJOPFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 11:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263378AbTJOPFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 11:05:52 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:40351 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263376AbTJOPFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 11:05:35 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16269.25149.823749.941199@laputa.namesys.com>
Date: Wed, 15 Oct 2003 19:05:33 +0400
To: Erik Bourget <erik@midmaine.com>
Cc: Josh Litherland <josh@temp123.org>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
In-Reply-To: <87wub6o8vl.fsf@loki.odinnet>
References: <1066163449.4286.4.camel@Borogove>
	<20031015133305.GF24799@bitwizard.nl>
	<16269.20654.201680.390284@laputa.namesys.com>
	<20031015142738.GG24799@bitwizard.nl>
	<87wub6o8vl.fsf@loki.odinnet>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Bourget writes:
 > Erik Mouw <erik@harddisk-recovery.com> writes:
 > 
 > > On Wed, Oct 15, 2003 at 05:50:38PM +0400, Nikita Danilov wrote:
 > >> Erik Mouw writes:
 > >>  > Nowadays disks are so incredibly cheap, that transparent compression
 > >>  > support is not realy worth it anymore (IMHO).
 > >> 
 > >> But disk bandwidth is so incredibly expensive that compression becoming
 > >> more and more useful: on compressed file system bandwidth of user-data
 > >> transfers can be larger than raw disk bandwidth. It is the same
 > >> situation as with allocation of disk space for files: disks are cheap,
 > >> but storing several files in the same block becomes more advantageous
 > >> over time.
 > >
 > > You have a point, but remember that modern IDE drives can do about
 > > 50MB/s from medium. I don't think you'll find a CPU that is able to
 > > handle transparent decompression on the fly at 50MB/s, even not with a
 > > simple compression scheme as used in NTFS (see the NTFS docs on
 > > SourceForge for details).
 > >
 > > Erik
 > >
 > > PS: let me guess: among other things, reiser4 comes with transparent
 > >     compression? ;-)
 > 
 > Reiser4 made my coffee this morning, it's wonderful :)
 > 
 > Seriously, though, (and getting off the topic), has anyone started to use
 > reiser4 in a high-load environment?  I've got a mail system that shoots a few
 > million messages through it every day and a filesystem that's faster with
 > creating and deleting tons of ~4kb qmail queue files (with data journaling!)
 > would be verrry innnteresting.

Please, don't use reiser4 in production environments. It is still in the
late debugging stage. Stay tuned, as they say. :)

 > 
 > - Erik Bourget
 > 

Nikita.
