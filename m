Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTJ3CKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 21:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTJ3CKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 21:10:41 -0500
Received: from mho.net ([64.58.22.195]:49383 "EHLO sm1420")
	by vger.kernel.org with ESMTP id S262119AbTJ3CKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 21:10:39 -0500
Date: Wed, 29 Oct 2003 19:09:09 -0700 (MST)
From: Alex Belits <abelits@phobos.illtel.denver.co.us>
X-X-Sender: abelits@sm1420.belits.com
To: Joseph Pingenot <trelane@digitasaru.net>
cc: Dax Kelson <dax@gurulabs.com>, Hans Reiser <reiser@namesys.com>,
       andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
In-Reply-To: <20031030002005.GC3094@digitasaru.net>
Message-ID: <Pine.LNX.4.58.0310291848590.11170@sm1420.belits.com>
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org>
 <3FA0475E.2070907@namesys.com> <1067466349.3077.274.camel@mentor.gurulabs.com>
 <20031030002005.GC3094@digitasaru.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Oct 2003, Joseph Pingenot wrote:

> >> them.
> >Except, they didn't release a beta.
> >They released a developer preview (not even alpha), mostly to show off
> >the APIs.
> >AFAIK the developer preview has no WinFS bits in it at all.
>
> Regardless, it's an interesting idea, and one which might be fruitful.

  There is another possibility -- that the only implementation of the
standardized indexable/searchable format that Microsoft wants to base this
system on is a horrendous resource pig, infected with inflexible
restrictions and requirements, that everything will have to follow, and
will be unable to do any further progress in various directions where
non-Microsoft software has advantage.

  What most of XML-based formats certainly are. If further development
will blindly take this road, we will lose huge amount of flexibility in
exchange for a certain Microsoft-compatible (for a while) system of
organizing data. But, say, using grep on a text file will become
impossible without making a XML-ified file, and XML-ified grep. Pipes and
sockets will have to be redesigned, too, and many kinds of low-level
functionality that Unixlike systems enjoyed thanks to unified file
descriptors and nonintrusive way of OS handling the data will become
cumbersome second-class citizens in a world where structured data files
(VMS? Mainframes?) and strong file-type binding (MacOS? PalmOS?) are what
the system is based on. Not to mention niceties like having to stuff the
whole expat into the kernel, and enjoy memory bloat and various kinds of
DoS based on that. It won't harm Microsoft a single bit -- it would be
their wet dream to outlaw all file formats but MS Office, and make every
program talk through the Office-based interface, but it will turn Linux
(or any other system that follows this idea) into something else.

It may be a great idea to add additional interfaces that will provide
a similar functionality through multiple userspace applications that will
form another layer of data access. But those can't be just stuffed into
kernel, or have one, set in stone format, imposed on files and queries. It
may allow something compatible with Microsoft, but it certainly should not
grant immortality to current incarnation of XML, SQL and derivatives of
those. Linux's greatest strength is in providing good infrastructure, and
just stuffing particular (bound to be bad) implementations of some ideas
(that are not necessarily good beyond their basic core) into the system
instead of providing sufficient infrastructure to provide those in various
ways, makes it more like an ideologically-charged finished environment
than an infrastructure for creating such environments. Microsoft always
created narrowly-defined, bloated, followed-the-party-line environments
that captured and confined the developers. There is no need to imitate
that in a system that is known for being just the opposite.

-- 
Alex
