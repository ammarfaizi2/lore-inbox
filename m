Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291460AbSBZREv>; Tue, 26 Feb 2002 12:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291624AbSBZREl>; Tue, 26 Feb 2002 12:04:41 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:4601
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291547AbSBZREh>; Tue, 26 Feb 2002 12:04:37 -0500
Date: Tue, 26 Feb 2002 09:05:20 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226170520.GJ4393@matchmail.com>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <fa.n4lfl6v.h4chor@ifi.uio.no> <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase> <20020225172048.GV20060@matchmail.com> <02022518330103.01161@grumpersII> <a5f7s4$2o1$1@cesium.transmeta.com> <20020226160544.GD4393@matchmail.com> <3C7BB9A3.30408@evision-ventures.com> <20020226164316.GH4393@matchmail.com> <3C7BBDE2.8050207@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7BBDE2.8050207@evision-ventures.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 05:54:58PM +0100, Martin Dalecki wrote:
> Mike Fedyk wrote:
> >Can you describe the pitfalls that VMS went through so we can aviod the
> >problems?
> >
> >I haven't had the chance to use VMS, and don't have any hardware to try it
> >out on.  Also, just because one implementation was bad (even long ago, and
> >unix was considered bad then too... ;) does it mean the entire idea is bad.
> 
> Yes I can. The main problem is that most people think that undeletion
> is a magical way of getting around stiupid users. 

That is one use, but not the only use.  It is one feature that is missing on
Linux.  I don't know what other unix-like systems have, but it'd be nice if
Linux had it.

>But the fact is
> that the very same users very quickly adapt to the the presence of
> undeletion facilities. And guess whot? They will expect you to
> instantly recover allways a version of "this" file from the "stone age".
> So the pain for the sysadmin will certainly not be decreased. Quite
> contrary for what he expects. 

Yes, I can understand this exactly, but it still doesn't negate the
usefulness of undeletion.

>For the educated user it was always a pain
> in the you know where, to constantly run out of quota space due to
> file versioning.

Ahh, so we'd need to chown the files to root (or a configurable user and
group) to get around the quota issue.

Mike
