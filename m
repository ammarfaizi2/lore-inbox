Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265297AbSJaSBG>; Thu, 31 Oct 2002 13:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265294AbSJaSBG>; Thu, 31 Oct 2002 13:01:06 -0500
Received: from main.gmane.org ([80.91.224.249]:18136 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S265297AbSJaSBD>;
	Thu, 31 Oct 2002 13:01:03 -0500
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: Nicholas Wourms <nwourms@netscape.net>
Subject: Re: What's left over.
Date: Thu, 31 Oct 2002 13:08:28 -0500
Message-ID: <aprrei$ete$1@main.gmane.org>
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <1036059364.2419.1.camel@aurora.localdomain>
Reply-To: nwourms@netscape.net
NNTP-Posting-Host: 130-127-121-177.generic.clemson.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: main.gmane.org 1036087571 15278 130.127.121.177 (31 Oct 2002 18:06:11 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Thu, 31 Oct 2002 18:06:11 +0000 (UTC)
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trever L. Adams wrote:

> On Wed, 2002-10-30 at 21:31, Linus Torvalds wrote:
> 
>> > ext2/ext3 ACLs and Extended Attributes
>> 
>> I don't know why people still want ACL's. There were noises about them
>> for samba, but I'v enot heard anything since. Are vendors using this?
>> 
> 
> I am sure I don't count (not being a vendor), but Intermezzo offers
> support for this (they are waiting on feature freeze to redo it to 2.5
> according to an email I have).  I want this stuff.  Yes, u+g+w is nice,
> but good ACLs are even better.  Please, if this is technically correct
> in implementation, do put it in.
> 

I agree, having them is far better then the standard u+g+w that's been 
around for ages.  I think it gives the "finer" grain of control over your 
system that a lot of users may desire.  Not to mention the fact that ACL's 
are well supported by the recently merged XFS.  If I'm not mistaken, AFS 
uses them as well.  I *really* don't see the overhead cost here in terms of 
compiled kernel size when they are turned off.  As for the size of the 
source tarball, who cares?  People should quit whining about the size of 
the sources and get over it!  Storage is cheap and broadband is in 
widespread use.

Cheers,
Nicholas


