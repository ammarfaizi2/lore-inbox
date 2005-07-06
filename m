Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVGFUPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVGFUPV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVGFUOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:14:10 -0400
Received: from services106.cs.uwaterloo.ca ([129.97.152.164]:60658 "EHLO
	services106.cs.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262358AbVGFULL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:11:11 -0400
X-Mailer: emacs 21.4.1 (via feedmail 8 I)
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Chet Hosey <chosey@nauticom.net>, Kevin Bowen <kevin@ucsd.edu>,
       Hans Reiser <reiser@namesys.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       David Masover <ninja@slaphack.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
From: Hubert Chan <hubert@uhoreg.ca>
References: <hubert@uhoreg.ca> <200507060251.j662p7OC005227@laptop11.inf.utfsm.cl>
X-Hashcash: 1:23:050706:vonbrand@inf.utfsm.cl::l0plwhWlXCBUBRi0:0000000000000000000000000000000000000000bQVk
X-Hashcash: 1:23:050706:chosey@nauticom.net::4HVtVp7qg9QgpgH4:0000000000000000000000000000000000000000008AZg
X-Hashcash: 1:23:050706:kevin@ucsd.edu::X1xNuhBHDW4qZm7f:000Y2u9
X-Hashcash: 1:23:050706:reiser@namesys.com::ciFDkXdx0jxyd+Oz:00000000000000000000000000000000000000000008JK3
X-Hashcash: 1:23:050706:mrmacman_g4@mac.com::OmbX13vp9CzRcXbG:000000000000000000000000000000000000000000fQaK
X-Hashcash: 1:23:050706:ninja@slaphack.com::yfkypsJGS+89uLtD:00000000000000000000000000000000000000000001ps1
X-Hashcash: 1:23:050706:valdis.kletnieks@vt.edu::rz7Ry4b1xALD2R1/:0000000000000000000000000000000000000094cY
X-Hashcash: 1:23:050706:ltd@cisco.com::r32Fm3UC6efHh2r7:0000GMVd
X-Hashcash: 1:23:050706:gmaxwell@gmail.com::FvGiGN3r6lpbW6N3:0000000000000000000000000000000000000000001Di5U
X-Hashcash: 1:23:050706:jgarzik@pobox.com::xf9s3ajWFopHUld+:000000000000000000000000000000000000000000004LPW
X-Hashcash: 1:23:050706:hch@infradead.org::dBi1Hqqm61PK0jPk:000000000000000000000000000000000000000000007Iri
X-Hashcash: 1:23:050706:akpm@osdl.org::Sqxmj8wpNYzBtc4D:0000G36H
X-Hashcash: 1:23:050706:linux-kernel@vger.kernel.org::oQHoxNiJpcK/RHSE:000000000000000000000000000000000ZMvy
X-Hashcash: 1:23:050706:reiserfs-list@namesys.com::tlS8BgzL0OrYvS1r:000000000000000000000000000000000000ygOS
Date: Wed, 06 Jul 2005 16:10:48 -0400
In-Reply-To: <200507060251.j662p7OC005227@laptop11.inf.utfsm.cl> (Horst von
 Brand's message of "Tue, 05 Jul 2005 22:51:07 -0400")
Message-ID: <87irznelvb.fsf@evinrude.uhoreg.ca>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (services106.cs.uwaterloo.ca [129.97.152.132]); Wed, 06 Jul 2005 16:11:00 -0400 (EDT)
X-Miltered: at rhadamanthus with ID 42CC3B17.001 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jul 2005 22:51:07 -0400, Horst von Brand <vonbrand@inf.utfsm.cl> said:

> Hubert Chan <hubert@uhoreg.ca> wrote:
>> On Fri, 01 Jul 2005 03:41:00 -0400, Chet Hosey <chosey@nauticom.net>
>> said:
>> > Horst von Brand wrote:
>> >> And who says that a normal user isn't allowed to annotate each and
>> >> every file with its purpose or something else?

>> Explain how you currently allow users to annotate arbitrary files.

> By keeping annotations /outside/ the files.

So if I want to share annotations, I have to look in 20 different
places?

> [...]

>> The situation is even better with file-as-dir.  If the administrator
>> wants to allow users to edit the description metadata for the file
>> foo, the administrator can set the appropriate permissions for
>> foo/.../description, and keep foo read-only.

> So now root is responsible in exquisite detail for random other users
> being able to keep info about my files?

I can grant people permissions to write random info into my own files.
Or they can use unionfs if I don't grant them permissions.

Remember: the above argument was citing an advantage of file-as-dir over
packed files (storing metadata as a tar or zip file, similar to what
OpenOffice.org does, or even something like exif or id3).  In a packed
file, I can't allow people to edit the description attribute without
allowing them to edit the entire file.  With file-as-dir, I get much
finer grained permissions.

> [...]

>> Actually, you could use something like unionfs to allow users to keep
>> their own annotations without affecting everyone else's.

> Again, root has to mount that stuff for each and every user?

suid program that allows union mount into a directory within my own tree
(or just into any directory that I have write permissions should be
sufficiently secure).

-- 
Hubert Chan <hubert@uhoreg.ca> - http://www.uhoreg.ca/
PGP/GnuPG key: 1024D/124B61FA
Fingerprint: 96C5 012F 5F74 A5F7 1FF7  5291 AF29 C719 124B 61FA
Key available at wwwkeys.pgp.net.   Encrypted e-mail preferred.

