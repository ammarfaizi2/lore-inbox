Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292384AbSCIB7u>; Fri, 8 Mar 2002 20:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292386AbSCIB7l>; Fri, 8 Mar 2002 20:59:41 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:60655
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292384AbSCIB71>; Fri, 8 Mar 2002 20:59:27 -0500
Date: Fri, 8 Mar 2002 18:00:18 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Val Henson <val@nmt.edu>
Cc: Erik Andersen <andersen@codepoet.org>,
        "Jonathan A. George" <JGeorge@greshamstorage.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
Message-ID: <20020309020018.GD896@matchmail.com>
Mail-Followup-To: Val Henson <val@nmt.edu>,
	Erik Andersen <andersen@codepoet.org>,
	"Jonathan A. George" <JGeorge@greshamstorage.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C87FD12.8060800@greshamstorage.com> <Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com> <20020308003827.GA8348@codepoet.org> <20020308185238.B25086@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020308185238.B25086@boardwalk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 06:52:38PM -0700, Val Henson wrote:
> On Thu, Mar 07, 2002 at 05:38:27PM -0700, Erik Andersen wrote:
> >
> > 6) Ability to do sane archival and renaming of directories.
> >     CVS doesn't even know what a directory is.
> 
> How about sane renaming of plain old files?
> 
> For a laugh, read the instructions on how to "rename" CVS files.
> Hint: "Rename" is not the correct word.
> 
> $ mv old new
> $ cvs remove old
> $ cvs add new
> $ cvs commit -m "Renamed old to new" old new
> 
> Gee, that looks like adding a new file to me.  Upon reading further,
> that is exactly what this "rename" operation is doing.  There are two
> other ways to rename a file in CVS, one of which is described as
> "dangerous" and the other as having "drawbacks."  References:
> 
> http://www.gnu.org/manual/cvs-1.9/html_node/cvs_66.html
> 
> Note that the way to rename a file in in BitKeeper is:
> 
> $ bk mv old new
> 
> No danger, no drawbacks, no hand editing of history files.
> 
> I strongly recommend that anyone attempting to make CVS a viable
> replacement for BitKeeper start out by actually using BitKeeper.
> You're so used to being crippled by CVS that you don't even know what
> you're missing.
> 

No.

They're not trying to make cvs fit into the space bk lives in now, they're
trying to take the cvs *replacements* (arch, subversion, etc) and make them
usable (they probably are close now, but not as good as bk) for kernel
development requirements.
