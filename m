Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263208AbVGAD5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbVGAD5n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 23:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbVGAD5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 23:57:43 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:42221 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263208AbVGAD5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 23:57:37 -0400
Message-Id: <200507010328.j613SV3h004647@laptop11.inf.utfsm.cl>
To: Kevin Bowen <kevin@ucsd.edu>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hubert Chan <hubert@uhoreg.ca>,
       Hans Reiser <reiser@namesys.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       David Masover <ninja@slaphack.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from Kevin Bowen <kevin@ucsd.edu> 
   of "Thu, 30 Jun 2005 13:08:42 MST." <1120162123.22241.53.camel@punchline.ucsd.edu> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Thu, 30 Jun 2005 23:28:31 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Bowen <kevin@ucsd.edu> wrote:
> > might be nice to have on exclusively one-user, isolated machines, like
> > "keep /my/ annotations/icon/application name/whatever with the file's
> > data", but that break down in multiuser (even serially, one user after the

> If this is really the core of your (and the rest of the reiser-
> obstructionist crowd's) objection to the file-as-directory concept, then
> you just haven't thought it through thoroughly enough. Ignore for the
> moment the case of system-wide or network-wide shared data,

I.e., something like 90% of the use of Linux here. OK.

>                                                             and think
> about it just limited to a user's home directory, and the storage and
> organization of actual *data* (as opposed to system files).

Who is to say what is "data" and what is "system files"? And if you are
limiting yourself to /user/ data, why not have the /user/ decide how they
want to organize it, and give them the tools?

>                                                             The desire
> amongst users for ubiquitous metadata is very real - the current wave of
> "desktop search" products and technologies demonstrates this - 

Just like each previous claim "this /must/ be the next cool technology!",
also called later the "dotcom crash"...

>                                                                but
> search is really only the lowest-hanging fruit of this new way of
> looking at data. Application-layer solutions like Beagle,

That works without screwing up the whole system, AFAIU.

>                                                           Google Desktop
> Search et al allow for querying on metadata, but actually *acting* on
> the results of those queries requires that they be exposed via first
> class primitives which can be manipulated with arbitrary tools, not via
> some proprietary userland api which only one tool ever actually
> implements. 

Could you please explain in plain english? The only part I get out is
"propietary API", and I don't see anybody advocating such here.

> As to the case of system-wide shared files, there is already a mechanism
> to prevent users from inappropriately annotating files that don't belong
> to them: file permissions.

And who says that a normal user isn't allowed to annotate each and every
file with its purpose or something else? I can very well imagine a system
in which users (say students in a Linux class) want to do so... on a shared
machine. Or users having a shared MP3 or photograph or ... collection, with
individual notes on each. Or even developers wanting to annotate source
code files with their comments, but leave them read-only (or have them
under SCM).

>                            If you're sysadmining a multiuser reiser4
> box, and your users are able to modify the metadata of files they don't
> own, then you go to sysadmin purgatory. 

Bingo! And thus goes much of the supposed advantage of this nonsense.

[I see that /opponents/ are accused here of lack of imagination, while I
 see that the /proponents/ lack imagination... or perhaps just real-world
 experience.]

> > other way; OpenOffice /has/ structured files, XML inside zipped files,
> > Java also uses zip files for its structuring needs, etc), or are ideas
> > that

> And as a Java developer, I can tell you that the wide consensus is that
> this solution is half-assed and insufficient for both developers and
> users needs. In fact, I believe there is currently a JSR in progress to
> develop a more sophisticated Java packaging model.

Presumably based on ReiserFS 4, which then has to be ported to whatever
platform you want to run Java on ASAP? Great for you! Wait a bit, and
you'll get what you want then, even across the board!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
