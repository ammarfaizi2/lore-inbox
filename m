Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265197AbSJaGuG>; Thu, 31 Oct 2002 01:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265198AbSJaGuG>; Thu, 31 Oct 2002 01:50:06 -0500
Received: from tapu.f00f.org ([66.60.186.129]:2788 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S265197AbSJaGuD>;
	Thu, 31 Oct 2002 01:50:03 -0500
Date: Wed, 30 Oct 2002 22:56:29 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021031065629.GA19030@tapu.f00f.org>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com> <20021031062249.GB18007@tapu.f00f.org> <1036046904.1521.74.camel@mentor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036046904.1521.74.camel@mentor>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 11:48:23PM -0700, Dax Kelson wrote:

> Technically speaking you can achieve ACL like permissions/behavior
> using the historical UNIX security model by creating a group EACH
> time you run into a unique case permission scenario.

I'm not arguing against this... I'm claiming POSIX ACLs are mostly
brain-dead and almost worthless (broken by committee pressure and too
many people making stupid concessions).

If we must have ACLs, why not do it right?

> Without ACLs, if Sally, Joe and Bill need rw access to a file/dir,
> just create another group with just those three people in.  Over
> time, of course, this leads to massive group proliferation.  Without
> Tim Hockin's patch, 32 groups is maximum number of groups a user can
> be a member of.

How many people actually need this level of complexity?

Why are we adding all this shit and bloat because of perceived
problems most people don't have?  What next, some kind of misdesigned
in-kernel CryptoAPI?



  --cw
