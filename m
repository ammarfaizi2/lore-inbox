Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268585AbTCCQv4>; Mon, 3 Mar 2003 11:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268586AbTCCQvz>; Mon, 3 Mar 2003 11:51:55 -0500
Received: from h-64-105-34-204.SNVACAID.covad.net ([64.105.34.204]:27296 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S268585AbTCCQvu>; Mon, 3 Mar 2003 11:51:50 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 3 Mar 2003 09:02:11 -0800
Message-Id: <200303031702.JAA02896@adam.yggdrasil.com>
To: esm@logic.net
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I've dropped all of the direct email addresses from the cc list.
I think they'd probably rather just see one copy of this tangential
discussion on the linux-kernel list, if at all. -Adam]

On Mon, 3 Mar 2003, Edward S. Marshall wrote:
>On Sat, Mar 01, 2003 at 06:23:21PM -0800, Adam J. Richter wrote:
>> 	Note that Subversion, in particular, is GPL incompatible and

>http://subversion.tigris.org/project_license.html

>I don't see anything particularly GPL-incompatible in there;

	I think the main incompatibility is part 3 (the advertising
requirement).  Regarding the Apache 1.1 license, which is used by
Subversion, http://www.fsf.org/licenses/license-list.html#OriginalBSD
says, "This is a permissive non-copyleft free software license with a
few requirements that render it incompatible with the GNU GPL. We urge
you not to use the Apache licenses for software you write. However,
there is no reason to avoid running programs that have been released
under this license, such as Apache."

>looks pretty much like a BSD-style license to me.

	FSF has said that they believe that only the "new style" BSD
licenses are GPL compatible.  They consider the "old style" (with the
advertising requirement) to be GPL incompatible.


>Something that precludes SVN's use
>by GPL'd projects, or precludes integration with GPL'd projects, is
>something I'm sure CollabNet and the developers on the mailing list would
>love to know about

	That is not what I mean by "GPL incompatible."

	http://www.fsf.org/licenses/gpl-faq.html#WhatDoesCompatMean
gives the foundation's definition of "compatible with the GPL":

| What does it mean to say a license is "compatible with the GPL".
| 
| 	It means that the other license and the GNU GPL are
| compatible; you can combine code released under the other license with
| code released under the GNU GPL in one larger program.
| 
|	The GPL permits such a combination provided it is released
| under the GNU GPL. The other license is compatible with the GPL if it
| permits this too.

	When I say "GPL compatible", my meaning is similar, perhaps
identical.  By "GPL compatible", I mean that if the contents of a work
are comingled with GPL'ed content, even within the same file, that
obeying the terms of the GPL with regard to the whole resultant work
results in one having at least the permissions of the GPL with regard
to the whole resultant work (this, by the way, is what I believe
"licensed as a whole" under the GPL means).

	I mentioned the GPL incompatibility issue to Brian Behlendorf
after a he gave at a trade show once, and he said, approximately, "it
is the GPL's fault, you know."  This discussion took place after the
University of California at Berkeley had switched to the new BSD terms
for GPL compatibility.  At that point, I believed that investing
further time in arguing would probably not produce useful results.


>Lacking an on-disk format that's actually useful for storing more
>information than files and diffs, they invented one.

	There already were free systems that deal with directory
information and change sets on groups of files rather than single
files.  The Subversion team chose to use a new format that I've heard
many people, even people who seem not to care about the GPL
incompatibility, says is complex enough to warrant not using svn.
Even when one of the Subversion people gave a talk at the Silicon
Valley Linux User Group, he acknowledged that many people on some
mailing list discussing Subversion design issues, including Larry
McVoy, considered their decision to be a big mistake.

>[...] svn is architected such that bolting up
>to another repository storage system (say, an RDBMS, or even, horrors, a
>bitkeeper-compatible SCCS derivative) is really just a matter of writing
>the code (with a few caveats, obviously, but that's the basic idea).

	That is arguably true of most source code control system that
try to deal with multi-file commits.  For example, Aegis already lets
you choose between rcs or sccs.

	All that said, I do not consider contribution to Subvresion to be
something that has a negative sum effect.  If you are contributing to
Subversion, I'm not saying that that is a bad thing.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
