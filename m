Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293060AbSCOS3c>; Fri, 15 Mar 2002 13:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293058AbSCOS3V>; Fri, 15 Mar 2002 13:29:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56590 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293048AbSCOS3M>; Fri, 15 Mar 2002 13:29:12 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux 2.4 and BitKeeper
Date: Fri, 15 Mar 2002 18:27:24 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a6teec$sis$1@penguin.transmeta.com>
In-Reply-To: <3C90E994.2030702@candelatech.com> <20020315080408.D11940@work.bitmover.com> <a6tcnf$shg$1@penguin.transmeta.com> <3C923A6A.2030905@mandrakesoft.com>
X-Trace: palladium.transmeta.com 1016216925 12374 127.0.0.1 (15 Mar 2002 18:28:45 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 15 Mar 2002 18:28:45 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C923A6A.2030905@mandrakesoft.com>,
Jeff Garzik  <jgarzik@mandrakesoft.com> wrote:
>
>I always check out my trees with "bk -r co -q" precisely because of 
>command-line completion.

That's fine for the command line completion, but it doesn't solve the
generic problem. No tree-based thing works unchanged.

The fact is, mixing up the revision control directories and the working
area is a design mistake, and one that BK perpetuated due to Larry's
infatuation with the fact that "make" and "patch" already know how SCCS
works. 

(It should be noted that this design mistake is also one of the
stumbling blocks for ever improving the BK databases. It limits your
viability in the long run, which is why I'm trying to prod Larry into
fixing it).

			Linus
