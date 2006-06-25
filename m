Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWFYFiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWFYFiv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 01:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWFYFiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 01:38:51 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:59777 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751403AbWFYFiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 01:38:50 -0400
Message-ID: <449E216E.8010508@sbcglobal.net>
Date: Sun, 25 Jun 2006 00:38:54 -0500
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Mark Rosenstand <mark@borkware.net>
CC: Al Viro <viro@ftp.linux.org.uk>, Daniel <damage@rooties.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernelsources writeable for everyone?!
References: <200606242000.51024.damage@rooties.de>	 <20060624181702.GG27946@ftp.linux.org.uk> <1151198452.6508.10.camel@mjollnir>
In-Reply-To: <1151198452.6508.10.camel@mjollnir>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rosenstand wrote:
> On Sat, 2006-06-24 at 19:17 +0100, Al Viro wrote:
>> On Sat, Jun 24, 2006 at 08:00:50PM +0200, Daniel wrote:
>>> Hi,
>>> may be this was reported/asked 999999999 times, but here ist the 1000000000th:
>>>
>>> I have downloaded linux-2.6.17.1 10 min ago and I noticed that every file is 
>>> writeable by everyone. What's going on there?
> 
> It's an abusive way of telling people to not extract the kernel sources
> as root. Surely if they don't follow the recommended workflow, their box
> deserve to be rooted.
> 

No, the inevitable flame war here is the abusive way of telling people 
not to extract the kernel sources as root.  This argument boils down to 
a fundamental disjunct: trust people to handle security of their own box 
their own way, with full knowledge of how their tools work, or assume 
that they aren't intelligent enough to use tools sanely and securely, 
and handicap so they don't have to.  The latter, much as it is not seen 
this way, is the abusive philosophy.  The former trusts the user.

Yes, there's a learning curve.  There is always a learning curve.  Never 
expect there not to be a learning curve.

The kernel archive is foremost an archive of a working directory.  The 
recommended workflow is sane, and is designed around the limitations of 
tools sensibly designed for a wide range of purposes, not foremost of 
which is kernel compilation.

Please learn to take advice.  It tends to be intended for your benefit, 
and is generally more useful when not viewed as a personal affront.

>> You are unpacking tarballs as root and preserve ownership and permissions.
>> Don't.
> 
> Preserving ownership and permissions is the default behaviour for GNU
> tar when running as root. Other implementations require the -p option.

Matt
