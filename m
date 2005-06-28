Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVF1Rvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVF1Rvo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVF1Rvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:51:43 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:59363 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262107AbVF1RvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:51:23 -0400
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
In-Reply-To: <2B1C058D-C304-4E15-ACDA-C3337E67E981@mac.com> (Kyle Moffett's
 message of "Tue, 28 Jun 2005 02:01:12 -0400")
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
	<42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com>
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
X-Hashcash: 1:23:050628:mrmacman_g4@mac.com::9HRp/Q6bjNusS9T8:000000000000000000000000000000000000000000Ch4Y
X-Hashcash: 1:23:050628:ninja@slaphack.com::WB0cqAvZCsj+9tg7:0000000000000000000000000000000000000000000TL5f
X-Hashcash: 1:23:050628:valdis.kletnieks@vt.edu::IPR2sQSEquLfOocT:00000000000000000000000000000000000000JVoz
X-Hashcash: 1:23:050628:ltd@cisco.com::OXP7dYHjJd6+gNR5:0000MCE/
X-Hashcash: 1:23:050628:gmaxwell@gmail.com::YQquP5GSZgfSsOQS:0000000000000000000000000000000000000000000dqDy
X-Hashcash: 1:23:050628:reiser@namesys.com::VhSOnW+migAucZsL:00000000000000000000000000000000000000000001MAM
X-Hashcash: 1:23:050628:vonbrand@inf.utfsm.cl::JnTY6XreF4Px6LOI:0000000000000000000000000000000000000000NUvc
X-Hashcash: 1:23:050628:jgarzik@pobox.com::doQaAjOTU5ZZ+9wm:00000000000000000000000000000000000000000000MuQ9
X-Hashcash: 1:23:050628:hch@infradead.org::uwJU9D/um/G7MJhk:0000000000000000000000000000000000000000000086GO
X-Hashcash: 1:23:050628:akpm@osdl.org::FcGZX73V+HmtRjJ8:0001RJA7
X-Hashcash: 1:23:050628:linux-kernel@vger.kernel.org::nlN5sU8pmaaWifAV:0000000000000000000000000000000001cIh
X-Hashcash: 1:23:050628:reiserfs-list@namesys.com::PQeOW4VY7lUQNaHr:000000000000000000000000000000000000okwy
Date: Tue, 28 Jun 2005 13:51:04 -0400
Message-ID: <87d5q6pdyv.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Miltered: at rhadamanthus with ID 42C18E49.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005 02:01:12 -0400, Kyle Moffett <mrmacman_g4@mac.com> said:

> On Jun 28, 2005, at 01:30:08, Hubert Chan wrote:
>> On Tue, 28 Jun 2005 00:38:38 -0400, Kyle Moffett
>> <mrmacman_g4@mac.com> said:
>>> Ok.  Those things should probably be divided up.  Stuff like POSIX
>>> extended attributes and such that have existing interfaces should
>>> use those.
>>  One of the claimed advantages of the '...' interface is that
>> everything is editable as a file.  So if someone wanted to edit the
>> description extended attribute for foo.txt, he would just run
>> "[editor] foo.txt/.../description" (or "[editor]
>> /meta/fs/$(getattrpath foo.txt)/description"), instead of needing to
>> use some special purpose editor.  It works well for things like being
>> able to use Gimp to edit a thumbnail or icon attribute.

> I don't disagree with the thumbnail/icon/description, but things like
> POSIX acls and extended attributes have _existing_ interfaces which
> should be used.

OK.  I agree with that.  Of course, Reiser4 can always present both
interfaces, just like it presented two interfaces to the stat data --
the regular interface and the metas (now '...') interface -- before
file-as-dir got disabled by default.

> I don't deny them the right to add other interfaces later, but such
> should be a secondary or tertiary patch, after the rest of the stuff
> is in.  In any case, if we were to provide an interface by which one
> could $EDITOR the POSIX ACLs, it should be done in the VFS where all
> filesystems can share it.

I don't know if VFS is the right place for it, but I agree that it would
be good to make it accessible to all filesystems.

>> The inspiration, I think, was the MacOS X/NeXTSTEP bundle format.
>> For example, MacOS X/NeXTSTEP .app file is actually a directory that
>> behaves much like an executable file (double-clicking a .app file in
>> the Finder launches the application, instead of opening the
>> directory).  However, it is in reality a directory that contains many
>> things that could be thought of as extended attributes (such as the
>> application icon, information about the application, etc.).  Since
>> the application icon is a real file, it can be edited by normal
>> graphics editors (not like Windows programs, where you need a special
>> icon editor).  And since it's inside the .app directory, it's
>> attached to the application (not like Linux, where the program is in
>> /usr/bin, and the icon is in /usr/share/pixmaps), so it makes package
>> management easier (to delete an application, just delete the .app
>> file -- don't need to look in /usr/share/pixmaps for the icon and
>> delete it).

> The key difference here is that Mac OS X does all of the bundle mess
> in userspace where it belongs. :-D (I know, I use it daily)

Yes.  It's handled by NSWorkspace which is approximately equivalent to
this sort of thing being handled by GnomeVFS or the KDE equivalent.  Of
course the problem with handling it in userspace is that behaviour isn't
uniform -- applications that don't use NSWorkspace (e.g. some
command-line utils, programs ported over from UNIX, etc.) won't have the
same behaviour.  Whether or not that is an actual problem seems to be
debatable.  (I don't use MacOS X, but I've done some programming in
GNUstep.)

Another problem is that it only works with bundle files.  e.g. I can't
add an icon to a regular txt file.  Tiger now supports xattrs, which you
could use for that functionality, but then we run into the problem again
of not being able to edit it with regular applications.

> I think that part of Reiser4 needs more review than it's been given at
> present.

Looking forward to the flamewar that happens when Namesys decides that
file-as-dir is ready to be turned on again. ;-)

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

