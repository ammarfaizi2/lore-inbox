Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVF2BuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVF2BuE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVF2Bn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:43:56 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:39854 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262274AbVF2BlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 21:41:13 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: David Masover <ninja@slaphack.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
In-Reply-To: <C7DB345A-CD35-4A4C-89F7-5BBD3CB83DF4@mac.com> (Kyle Moffett's
 message of "Tue, 28 Jun 2005 15:59:03 -0400")
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
	<200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>
	<42BF08CF.2020703@slaphack.com>
	<200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>
	<42BF2DC4.8030901@slaphack.com>
	<200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
	<42BF667C.50606@slaphack.com>
	<5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com>
	<42BF7167.80201@slaphack.com>
	<EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com>
	<42C06D59.2090200@slaphack.com>
	<CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com>
	<42C08B5E.2080000@slaphack.com> <87y88vrzkg.fsf@evinrude.uhoreg.ca>
	<EBD8F590-0113-4509-9604-E6967C65C835@mac.com>
	<87mzpbrvpf.fsf@evinrude.uhoreg.ca>
	<D3A4ABBF-8062-4399-B1EC-61722295944A@mac.com>
	<87irzzrqu7.fsf@evinrude.uhoreg.ca>
	<2B1C058D-C304-4E15-ACDA-C3337E67E981@mac.com>
	<87d5q6pdyv.fsf@evinrude.uhoreg.ca>
	<C7DB345A-CD35-4A4C-89F7-5BBD3CB83DF4@mac.com>
X-Hashcash: 1:23:050629:mrmacman_g4@mac.com::h9/U46gqoJAdtJWA:000000000000000000000000000000000000000000dFmG
X-Hashcash: 1:23:050629:ninja@slaphack.com::PKx328E6hgEM3xM3:0000000000000000000000000000000000000000000tRL0
X-Hashcash: 1:23:050629:valdis.kletnieks@vt.edu::agj4r0ud3FyQ5mYP:000000000000000000000000000000000000006IXA
X-Hashcash: 1:23:050629:ltd@cisco.com::P1wbFCzJr0795B90:00006/qo
X-Hashcash: 1:23:050629:gmaxwell@gmail.com::qxBmITSDcVSpMqTS:0000000000000000000000000000000000000000000Ak8N
X-Hashcash: 1:23:050629:reiser@namesys.com::u/Xt34yUfdAJ2uMp:00000000000000000000000000000000000000000013lGO
X-Hashcash: 1:23:050629:vonbrand@inf.utfsm.cl::Yt0r4PCBWrsV1P96:0000000000000000000000000000000000000000/R4w
X-Hashcash: 1:23:050629:jgarzik@pobox.com::aDv2SKj1KLJH1D/o:00000000000000000000000000000000000000000000AlE7
X-Hashcash: 1:23:050629:hch@infradead.org::CdxBB/Y0P1yvaIk8:00000000000000000000000000000000000000000000KnjA
X-Hashcash: 1:23:050629:akpm@osdl.org::Supu0wpJOme5nKA9:00003iz6
X-Hashcash: 1:23:050629:linux-kernel@vger.kernel.org::LsLZobY0cIWe9lrv:000000000000000000000000000000000WJue
X-Hashcash: 1:23:050629:reiserfs-list@namesys.com::BGf8jHJ2wqTjd0jv:0000000000000000000000000000000000002SaB
Date: Tue, 28 Jun 2005 21:40:41 -0400
Message-ID: <874qbiey92.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Miltered: at rhadamanthus with ID 42C1FC5B.003 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005 15:59:03 -0400, Kyle Moffett <mrmacman_g4@mac.com> said:

> On Jun 28, 2005, at 13:51:04, Hubert Chan wrote:

>>  I don't know if VFS is the right place for it, but I agree that it
>> would be good to make it accessible to all filesystems.

> That's somewhat of a contradiction in terms.  The whole point of the
> VFS is to hold all of the things that multiple filesystems want to
> share :-D.

VFS provides a common interface to the filesystem.  I don't think metafs
needs any VFS changes.  It may be able to get by without making changes
to the VFS, and if so, it shouldn't touch the VFS.  It should just be
its own separate filesystem.

I imagine most of it could be implemented by a FUSE filesystem.

> Personally, I think that the multiple views is a good thing.  I like
> being able to "cd /Applications/Games/UnrealTournament2004.app/System"
> and mess with my game files, while double-clicking it in the Finder
> just starts it so I can get on with owning my friends :-D.

Of course.  With file-as-dir, you can "cd /usr/games/tetris/..." and
mess with the game files, or you can run "/usr/games/tetris" and get on
with ... stacking blocks.  The advantage of doing it in the kernel is
that you don't need extra support from the applications (or GnomeVFS or
KDE).  So typing "/usr/games/tetris" from the command prompt does the
same thing as double-clicking it in the file manager.  Of course, this
change does require file managers to understand default actions when
it's ambiguous what to do on a double-click -- but MacOS X has that too,
in the form of the "Open as Folder" option (or whatever it's called).

>> Another problem is that it only works with bundle files.  e.g. I
>> can't add an icon to a regular txt file.  Tiger now supports xattrs,
>> which you could use for that functionality, but then we run into the
>> problem again of not being able to edit it with regular applications.

> Maybe we just need better regular applications?

You mean patch them all so that they understand and can edit
xattr/substreams/etc.?  The file-as-dir interface is meant to avoid
having to do that.  metafs also avoids having to patch all the
applications by exposing them as regular files.

The example you give below isn't a new VFS API.  It's metafs exposing
xattrs/substreams/etc. through the regular file interface.  (Perhaps
we're just using different terminology.)

> I think that for the icon case, for the Samba/streams case, and for
> many others I'm probably forgetting, we should try to come up with a
> new "data-stream" VFS API, so that the icon data and other larger
> quantities can be stored in a filesystem without much effort.  Such a
> layer could even be bridged onto existing filesystems via a
> VFS-wrapper bind-mount:

> # mount -t reiser4 /dev/hda1 /mnt1

> # mount -t ext3 /dev/hda2 /mnt2

> # cat $(metapath /mnt1/foo)/streams/description
> Some random file

> # cat $(metapath /mnt2/foo)/streams/description
> cat: Unsupported operation

> # mount -t none -o bind,streamify /mnt2 /mnt3

> # cat $(metapath /mnt3/foo)/streams/description
> Another random file

> Such a wrapper interface might use the directory '...' to store files
> on the underlying filesystem, but I don't think that the meta
> interface itself should use those directories.

Agreed.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

