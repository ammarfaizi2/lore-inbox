Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310536AbSCGUzM>; Thu, 7 Mar 2002 15:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310535AbSCGUzA>; Thu, 7 Mar 2002 15:55:00 -0500
Received: from bitmover.com ([192.132.92.2]:8331 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310539AbSCGUxo>;
	Thu, 7 Mar 2002 15:53:44 -0500
Date: Thu, 7 Mar 2002 12:53:42 -0800
From: Larry McVoy <lm@bitmover.com>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Andrew Morton <akpm@zip.com.au>, Pavel Machek <pavel@ucw.cz>,
        Kent Borg <kentborg@borg.org>,
        The Open Source Club at The Ohio State University 
	<opensource-admin@cis.ohio-state.edu>,
        linux-kernel@vger.kernel.org, opensource@cis.ohio-state.edu
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux Maintainers
Message-ID: <20020307125342.B2304@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Troy Benjegerdes <hozer@drgw.net>, Andrew Morton <akpm@zip.com.au>,
	Pavel Machek <pavel@ucw.cz>, Kent Borg <kentborg@borg.org>,
	The Open Source Club at The Ohio State University <opensource-admin@cis.ohio-state.edu>,
	linux-kernel@vger.kernel.org, opensource@cis.ohio-state.edu
In-Reply-To: <20020305165233.A28212@fireball.zosima.org> <20020305163809.D1682@altus.drgw.net> <20020305165123.V12235@work.bitmover.com> <20020306095434.B6599@borg.org> <20020306085646.F15303@work.bitmover.com> <20020306221305.GA370@elf.ucw.cz>, <20020306221305.GA370@elf.ucw.cz>; <20020307101701.S1682@altus.drgw.net> <3C87C583.C8565E4B@zip.com.au> <20020307145031.V1682@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020307145031.V1682@altus.drgw.net>; from hozer@drgw.net on Thu, Mar 07, 2002 at 02:50:31PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then I'd really like to see scripts to make it easy to go from
> $YOUR_FAVORITE_SCM -> patch -> BK, while keeping important metadata, like,
> oh, say, comments. 

We already have an interface for this, Linus asked for it.  It will be in
the next release and it is in the download/test release.  You import your
patch and then stomp on the default comments with a comments file in the
format below.  If this isn't what you had in mind, let me know.

--lm

bk comments(1)       BitKeeper User's Manual       bk comments(1)

NAME
       bk comments - change checkin comments

SYNOPSIS
       bk   comments   [-p]   [-C<csetrev>]  [-r<rev>]  [-y<cmt>]
       [-Y<file>] [file ...] [-]

DESCRIPTION
       The comments command changes the  stored  comments  for  a
       revision  controlled  file.  The comments may be specified
       on the command line, or if  they  are  not,  you  will  be
       placed in your editor to type in the comments.

       If  given - for a file argument, then comments will read a
       list of files and comments to be  edited  in  batch.   The
       format is like:

           ### Comments for file.c|1.23
           this is a sample comment
           ### Comments for file2.h|1.2.3.4
           these are
           other comments

Etc.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
