Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVF1Fay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVF1Fay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVF1Fay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:30:54 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:35817 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261156AbVF1Fad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:30:33 -0400
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
In-Reply-To: <D3A4ABBF-8062-4399-B1EC-61722295944A@mac.com> (Kyle Moffett's
 message of "Tue, 28 Jun 2005 00:38:38 -0400")
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
	<42BE3645.4070806@cisco.com>
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
	<87mzpbrvpf.fsf@evinrude.uhoreg.ca>
	<D3A4ABBF-8062-4399-B1EC-61722295944A@mac.com>
X-Hashcash: 1:23:050628:mrmacman_g4@mac.com::2zqOlT3UakxKH3AK:000000000000000000000000000000000000000000yPeM
X-Hashcash: 1:23:050628:ninja@slaphack.com::vWNGBPSI8LQe0vl+:0000000000000000000000000000000000000000002I5Hf
X-Hashcash: 1:23:050628:valdis.kletnieks@vt.edu::ehiy4pxk5rU8DXgQ:00000000000000000000000000000000000000A427
X-Hashcash: 1:23:050628:ltd@cisco.com::5xthxHTVhNoFNyma:0000GrgV
X-Hashcash: 1:23:050628:gmaxwell@gmail.com::sG6TFV57YVNdDaH4:0000000000000000000000000000000000000000000HTmd
X-Hashcash: 1:23:050628:reiser@namesys.com::pXII1HGzxCKMh0+V:0000000000000000000000000000000000000000000C8RS
X-Hashcash: 1:23:050628:vonbrand@inf.utfsm.cl::f3TbZ9rrlAA/bvOK:0000000000000000000000000000000000000000DxHM
X-Hashcash: 1:23:050628:jgarzik@pobox.com::ZBdXy5WGGXejRUt/:000000000000000000000000000000000000000000004aws
X-Hashcash: 1:23:050628:hch@infradead.org::bOgJstIcjaZjajgO:00000000000000000000000000000000000000000000f2iD
X-Hashcash: 1:23:050628:akpm@osdl.org::9DMoOxXzRwy3fHfO:0000LSkR
X-Hashcash: 1:23:050628:linux-kernel@vger.kernel.org::qULddCLxskYvx+/B:000000000000000000000000000000000scu9
X-Hashcash: 1:23:050628:reiserfs-list@namesys.com::gHkqAQcD9J4H7C4Z:0000000000000000000000000000000000002Re3
Date: Tue, 28 Jun 2005 01:30:08 -0400
Message-ID: <87irzzrqu7.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Agree with most of the stuff you wrote.

On Tue, 28 Jun 2005 00:38:38 -0400, Kyle Moffett <mrmacman_g4@mac.com> said:

> On Jun 27, 2005, at 23:45:00, Hubert Chan wrote:

>> I think for most people on the reiser-fs list, the '...' directory
>> represents an interface to many things including
>> - automatic aggregating/tar/untar/compress
>> - a different interface to stat data
>> - adding extended attributes/substreams/acls/etc.
>> - anything else you might imagine

> Ok.  Those things should probably be divided up.  Stuff like POSIX
> extended attributes and such that have existing interfaces should use
> those.

One of the claimed advantages of the '...' interface is that everything
is editable as a file.  So if someone wanted to edit the description
extended attribute for foo.txt, he would just run
"[editor] foo.txt/.../description" (or
"[editor] /meta/fs/$(getattrpath foo.txt)/description"), instead of
needing to use some special purpose editor.  It works well for things
like being able to use Gimp to edit a thumbnail or icon attribute.

Of course, it shouldn't be too hard to provide both interfaces, as long
as you get locking and caching right...

The Reiser4 file-as-dir interface is also supposed to be more flexible
than POSIX extended attributes.  For example adding attributes to
attributes (e.g. adding a mimetype attribute to a thumbnail attribute).
The point of it is to present many different things (extended
attributes, file manipulation magic like automatic compress, etc.)
through a single interface that everyone knows how to use (i.e. regular
files) so that people can use regular programs to edit or manipulate
them.

The inspiration, I think, was the MacOS X/NeXTSTEP bundle format.  For
example, MacOS X/NeXTSTEP .app file is actually a directory that behaves
much like an executable file (double-clicking a .app file in the Finder
launches the application, instead of opening the directory).  However,
it is in reality a directory that contains many things that could be
thought of as extended attributes (such as the application icon,
information about the application, etc.).  Since the application icon is
a real file, it can be edited by normal graphics editors (not like
Windows programs, where you need a special icon editor).  And since it's
inside the .app directory, it's attached to the application (not like
Linux, where the program is in /usr/bin, and the icon is in
/usr/share/pixmaps), so it makes package management easier (to delete an
application, just delete the .app file -- don't need to look in
/usr/share/pixmaps for the icon and delete it).

> Other types of data should chose other interfaces that make the most
> sense for that type of data.  I think that the /meta fs should
> probably only be used when the data is generated from the existing
> file or directory, and perhaps a few other cases.

[...]

>> One other minor annoyance is it isn't easy to go backwards from the
>> ... directory to the file.  e.g. if I have a symlink that points to
>> /attr/fs/2/92036, I don't know what file's attributes that refers to.
>> Hopefully I'm sane enough to give the symlink a descriptive enough
>> name...

> I don't see this occurring often enough to be a major problem,

I don't see that this should be a major problem either, but I thought it
was worth bringing up.

> and in any case inodes are not path-exclusive (think hardlinks).  If
> they have the filedescriptor open, however, they could use
> /proc/$PID/* to figure out where the file is.

Although I guess if they have a file descriptor open, they probably have
the original filename lying around somewhere...

[...]

> On another note, it's nice to see the flamewar has died out and
> several technical discussions are taking place on various levels :-D.

Agreed! :-D

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

