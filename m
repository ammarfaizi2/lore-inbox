Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266259AbTAOL7B>; Wed, 15 Jan 2003 06:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbTAOL7B>; Wed, 15 Jan 2003 06:59:01 -0500
Received: from mailsrv.otenet.gr ([195.170.0.5]:9660 "EHLO mailsrv.otenet.gr")
	by vger.kernel.org with ESMTP id <S266259AbTAOL7A> convert rfc822-to-8bit;
	Wed, 15 Jan 2003 06:59:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: =?iso-8859-7?b?tuPj5evv8iDP6erv7e/s/PDv9evv8g==?= 
	<aoiko@cc.ece.ntua.gr>
Reply-To: aoiko@cc.ece.ntua.gr
To: Ian Wienand <ianw@gelato.unsw.edu.au>, Con Kolivas <conman@kolivas.net>
Subject: Re: [ANNOUNCE] contest benchmark v0.60
Date: Wed, 15 Jan 2003 14:08:13 +0200
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Cliff White <cliffw@osdl.org>
References: <1042500483.3e234b8335def@kolivas.net> <200301151416.54557.conman@kolivas.net> <20030115041524.GE21742@cse.unsw.edu.au>
In-Reply-To: <20030115041524.GE21742@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301151351.05419.aoiko@cc.ece.ntua.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 January 2003 06:15, Ian Wienand wrote:
> On Wed, Jan 15, 2003 at 02:16:48PM +1100, Con Kolivas wrote:
> > Ok some mildly annoying bugs have already shown up in this release.
> >
> > I've put up a contest-0.61pre on the contest website that addresses the
> > one which ruins the results and has some of the changes going into 0.61
>
> Con/Aggelos,
>
> What was the motivation for re-writing in C?

I gave up trying to make the script work in my desktop, which runs freebsd 
(too many little differences in the utilities used).

> I've done some hacking on the old version here, and so I realise that
> such a big shell script was getting a little out of hand, but surely
> perl or python is a better option for this application?

The script also had a few bugs that were actually artifacts of using bash 
(e.g. you had to use killall instead of just killing your children).

> If it's going to stay in C maybe we could integrate profiling support
> from /proc/profile, bypassing readprofile?  One of the guys here
> recently wanted to get profiling information from his program, and it
> would have been really good to have a library that could reset, start,
> pause and return in some format the profiling data.  If you think your
> users might be interested in profile outputs I can write something
> maybe we can both use.

Feel free to do so. I won't be able to help because
a) I'm not interested the feature :)
b) I don't have the time, I'm just helping Con squash most of the bugs in my 
code.

-- 
Follow each decision as closely as possible with its associated action.
            - The Elements of Programming Style (Kernighan & Plaugher)


