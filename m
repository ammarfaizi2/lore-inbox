Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSEGVNM>; Tue, 7 May 2002 17:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315972AbSEGVNL>; Tue, 7 May 2002 17:13:11 -0400
Received: from 216-42-72-144.ppp.netsville.net ([216.42.72.144]:50617 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S315971AbSEGVNK>; Tue, 7 May 2002 17:13:10 -0400
Subject: Re: [reiserfs-dev] [BK] [2.4] Reiserfs changeset 2 out of 4, please
	apply.
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Oleg Drokin <green@namesys.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
In-Reply-To: <3CD82859.5060707@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 07 May 2002 17:12:38 -0400
Message-Id: <1020805958.32044.186.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-07 at 15:17, Hans Reiser wrote:

> >In short, these changes are not "huge", and mostly non-intrusive.
> >
> Chris, I had much the same reaction initially, and then I looked at the 
> details, and either it fixes a real bug in a simple manner, or it is a 
> comment change, etc.  It looks bigger than it is was what I finally 
> concluded.  Perhaps there is some detail in which I am wrong, but since 
> it was all tested together I didn't feel like picking out just a few 
> lines of change to leave out (since that would actually increase the 
> risk of introducing a bug).

I think it is very important to only include critical fixes at this
stage in the release cycle, especially in a kernel where we are actively
looking for a possible bug.

I also think that patch (#3) should be integrated in 2.4.20preX, along
with the iput deadlock fix like Oleg did for 2.5.  It will clean the
code with fewer silly changes, and let us avoid rediffing the iput
deadlock fix against the new stuff.

-chris


