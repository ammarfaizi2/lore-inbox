Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVF1Dpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVF1Dpe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 23:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbVF1Dpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 23:45:33 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:36570 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262400AbVF1DpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 23:45:16 -0400
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
In-Reply-To: <EBD8F590-0113-4509-9604-E6967C65C835@mac.com> (Kyle Moffett's
 message of "Mon, 27 Jun 2005 22:59:24 -0400")
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
	<200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>
	<42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com>
	<e692861c05062522071fe380a5@mail.gmail.com>
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
X-Hashcash: 1:23:050628:mrmacman_g4@mac.com::igLbtPYHGOxNUaq+:000000000000000000000000000000000000000001QCt8
X-Hashcash: 1:23:050628:ninja@slaphack.com::t8iToXXnkB3OZc9y:0000000000000000000000000000000000000000000aEb9
X-Hashcash: 1:23:050628:valdis.kletnieks@vt.edu::57azIukefYHwj6SI:00000000000000000000000000000000000000cZmD
X-Hashcash: 1:23:050628:ltd@cisco.com::GUQqE/c7bRLFOuCW:0000671A
X-Hashcash: 1:23:050628:gmaxwell@gmail.com::B0xCzgbH7bXr6d7M:00000000000000000000000000000000000000000002RfD
X-Hashcash: 1:23:050628:reiser@namesys.com::x3P2ijOmEFk30/7z:0000000000000000000000000000000000000000001gown
X-Hashcash: 1:23:050628:vonbrand@inf.utfsm.cl::maJtEb7nMq26fTjK:00000000000000000000000000000000000000002aEm
X-Hashcash: 1:23:050628:jgarzik@pobox.com::SVooBVRaoD89egNE:00000000000000000000000000000000000000000000/zZ9
X-Hashcash: 1:23:050628:hch@infradead.org::LlvhRuhYMqUWAc/v:00000000000000000000000000000000000000000000aJ/a
X-Hashcash: 1:23:050628:akpm@osdl.org::+FLnmic/4dykNgt6:0000xkEG
X-Hashcash: 1:23:050628:linux-kernel@vger.kernel.org::w4lSlHlR5lCcvFlx:0000000000000000000000000000000002zBs
X-Hashcash: 1:23:050628:reiserfs-list@namesys.com::OA9ep8rw6rU/SzMW:000000000000000000000000000000000000zUI6
Date: Mon, 27 Jun 2005 23:45:00 -0400
Message-ID: <87mzpbrvpf.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Miltered: at aeacus with ID 42C0C7D4.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005 22:59:24 -0400, Kyle Moffett <mrmacman_g4@mac.com> said:

> On Jun 27, 2005, at 22:21:35, Hubert Chan wrote:
>> On Mon, 27 Jun 2005 18:27:26 -0500, David Masover
>> <ninja@slaphack.com> said:
>>> Kyle Moffett wrote:

[...]

>>>> /attr/fd/$FD_NUM == '...' directory for a filedescriptor
>>>> /attr/fs/$DEV_NUM/$INODE_NUM == '...' directory for an inode

[...]

> These are not really "attributes" so much as they are "metadata", for
> example, a "contents" subdirectory, if one existed, would be based on
> the original file, and therefore non-unique, but would be looked up
> based on information about the original file.

I think for most people on the reiser-fs list, the '...' directory
represents an interface to many things including
- automatic aggregating/tar/untar/compress
- a different interface to stat data
- adding extended attributes/substreams/acls/etc.
- anything else you might imagine
(I think this is your understanding too?  Just double-checking.)
So some of that stuff would be separate from the file.  (Separate in the
sense that it's not generated from the file's binary data.)

Personally, I don't like it all being in one directory, but it's not
that important.

>> You can still symlink.  It just takes a little more effort to figure
>> out what $DEV_NUM/$INODE_NUM to use.

> Also, unlike a symlink, if the path doesn't change and the file does,
> it will break, also, if the file is removed and another created
> elsewhere, it will be redirected improperly.  Perhaps a new symlink
> syntax is needed to allow attribute specification (Ick, more changes
> :-\).

I think those breakages are acceptable.  (IMHO) In other words, I think
it would not occur very often without the user being aware of it, and
should very rarely result in catastrophic effects.

One other minor annoyance is it isn't easy to go backwards from the
... directory to the file.  e.g. if I have a symlink that points to
/attr/fs/2/92036, I don't know what file's attributes that refers to.
Hopefully I'm sane enough to give the symlink a descriptive enough
name...

>>> Hans, thoughts?  Seems to be namespace fragmentation, but seems
>>> usable, less breakage, and so on.  And should it be /attr or /meta?
>>  For the mount point, it doesn't matter; it's up to the user.  It's
>> the attrfs or metafs or ???fs that matters (but which will greatly
>> influence whether people user /attr or /meta).

> "meta" seems the more descriptive name.  There should also probably be
> a somewhat standardized location for this, such that programs can
> locate it without much trouble.

Agreed.  Ultimately, it's the user's decision where to put it, but
probably 99.99999% of all people will put it in the same place.  Just
like you could put procfs or sysfs somewhere other than /proc or /sys if
you really wanted to, but nobody does that.

> This mechanism would be usable from all FSs, and could be built into
> the VFS.  Also, it would allow one to access the meta data of meta
> data (if supported by the filesystem, and possibly only through the
> file descriptor lookup, due to numbering limitations.)

One other issue is that the attrfs/metafs needs to communicate with the
other filesystem somehow.  It needs to know if the filesystem can handle
storing of extended attributes/substreams/etc. so that it knows whether
or not to allow those interfaces.  In my
/attr/fs/$(getattrpath /attr/fs/$(getattrpath ~/foo)/thumbnail)/mimetype
example, it needs to be smart enough to store that in ~/foo's
filesystem.  etc.

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

