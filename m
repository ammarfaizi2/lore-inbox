Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265256AbSJaSWh>; Thu, 31 Oct 2002 13:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265244AbSJaSW0>; Thu, 31 Oct 2002 13:22:26 -0500
Received: from main.gmane.org ([80.91.224.249]:6366 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S265237AbSJaSVd>;
	Thu, 31 Oct 2002 13:21:33 -0500
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: What's left over.
Date: Thu, 31 Oct 2002 13:28:59 -0500
Message-ID: <aprsl0$khj$1@main.gmane.org>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.LNX.4.44L.0210310105160.1697-100000@imladris.surriel.com> <20021031062249.GB18007@tapu.f00f.org> <1036046904.1521.74.camel@mentor> <20021031065629.GA19030@tapu.f00f.org>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130-127-121-177.generic.clemson.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1036088801 21043 130.127.121.177 (31 Oct 2002 18:26:40 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Thu, 31 Oct 2002 18:26:40 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

> On Wed, Oct 30, 2002 at 11:48:23PM -0700, Dax Kelson wrote:
> 
>> Technically speaking you can achieve ACL like permissions/behavior
>> using the historical UNIX security model by creating a group EACH
>> time you run into a unique case permission scenario.
> 
> I'm not arguing against this... I'm claiming POSIX ACLs are mostly
> brain-dead and almost worthless (broken by committee pressure and too
> many people making stupid concessions).
> 
> If we must have ACLs, why not do it right?
> 
>> Without ACLs, if Sally, Joe and Bill need rw access to a file/dir,
>> just create another group with just those three people in.  Over
>> time, of course, this leads to massive group proliferation.  Without
>> Tim Hockin's patch, 32 groups is maximum number of groups a user can
>> be a member of.
> 
> How many people actually need this level of complexity?
> 
> Why are we adding all this shit and bloat because of perceived
> problems most people don't have?  What next, some kind of misdesigned
> in-kernel CryptoAPI?

Get over it!  If you haven't noticed, CryptoAPI is merged already.  The only 
bloat ACLs cause is the size of the source tarball.  If your connection is 
slow or you are out of diskspace, too bad!  I'm sure I'm not the only one 
who is tired of hearing people whine about "bloat" wrt the sources and 
demanding that features they don't use be ignored.  No one (non-core) 
feature will be useful to everyone, that is a given fact.  The point is 
that while you see no use for it, there are many others out there who do.  
ACLs are something which have existed in the Solaris/BSD world for a long 
time now, and people who have admin these boxen find ACLs to be quite 
useful.

Cheers,
Nicholas


