Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289822AbSBYRY3>; Mon, 25 Feb 2002 12:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291972AbSBYRW2>; Mon, 25 Feb 2002 12:22:28 -0500
Received: from air-2.osdl.org ([65.201.151.6]:41995 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292996AbSBYRUo>;
	Mon, 25 Feb 2002 12:20:44 -0500
Date: Mon, 25 Feb 2002 09:13:41 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Hans Reiser <reiser@namesys.com>
cc: Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
        Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>, <green@thebsh.namesys.com>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <3C766C93.70109@namesys.com>
Message-ID: <Pine.LNX.4.33L2.0202250855310.11464-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Hans Reiser wrote:

| We need to move from discussing whether Linus can scale to whether the
| Linux Community can scale.

I have to agree with much of what Hans has written here.

and one of the biggest things that would help in this regard, IMHO,
is to (dare I say "require") provide documentation for kernel
API changes or semantics.  "Read the source" or "Use the source"
doesn't scale well either, when 10K kernel developers are
trying to use a new widget in 2.5.4, but they all ask questions
on lkml about how it's done.

Let's keep Documentation/* stuff up to date.  Whether it's in
text or DocBook format doesn't matter much.
Or have web pages for it if that's preferred by the project or
individual(s).

  ~Randy

| Every organization needs to have clearly defined algorithms for
| determining what work is done by who.  For the linux community, our work
| consists in part of reviewing patches.  Incoherent inconsistent
| delegation is the only reason why we are having scaling problems.  We
| have a consistent recurring problem (yes, I know, a few lucky folks like
| me don't have this problem, but it is clear to see that WE as a
| community have this problem).
|
| It is important that there be  a consistent feeling among patch
| submitters that they know where to send their patches for
| acceptance/rejection.  There should be NO patches which go out, and not
| even a rejection comes back.
|
| Every organization has clearly defined procedures for allocating the
| flow of work.  It is called a management structure.  That is what we
| need, and we need a formal well defined and externally visible one.  An
| informal undefined network of friends is just not suitable for an
| organization where the flow of email is as large as it is in the Linux
| Community.
|
| Linus, I would like you to stop saying that you cannot scale to where
| you can read every email, and start determining what it takes to make
| the Linux Community infrastructure underneath you responsive to patches.
|  Bitkeeper is a great start, but you also need to create  a management
| structure and interface that is clearly defined to the external
| community.  Saying that the maintainers list is ignored by you means
| that you need to create something that is not ignored by you.  You also
| need to create a system (bitkeeper can perhaps help, Larry?) for
| tracking who fails to respond to patches, and (after a few warnings)
| remove them as maintainers.
|
| Our problems are not novel.  Let us apply standard business school
| methodologies to them.

