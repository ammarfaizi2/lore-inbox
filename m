Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284135AbRLGRXi>; Fri, 7 Dec 2001 12:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284254AbRLGRX2>; Fri, 7 Dec 2001 12:23:28 -0500
Received: from bitmover.com ([192.132.92.2]:61839 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284135AbRLGRXR>;
	Fri, 7 Dec 2001 12:23:17 -0500
Date: Fri, 7 Dec 2001 09:23:14 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Larry McVoy <lm@bitmover.com>, Henning Schmiedehausen <hps@intermeta.de>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011207092314.F27589@work.bitmover.com>
Mail-Followup-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Larry McVoy <lm@bitmover.com>,
	Henning Schmiedehausen <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011207080603.B6983@work.bitmover.com> <2692295916.1007714643@[10.10.1.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <2692295916.1007714643@[10.10.1.2]>; from Martin.Bligh@us.ibm.com on Fri, Dec 07, 2001 at 08:44:03AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 08:44:03AM -0800, Martin J. Bligh wrote:
> I'm taking mercy on people and trimming down the cc: list ...
> 
> >> What I don't like about the approach is the fact that all nodes should
> >> share the same file system. One (at least IMHO) does not want this for
> >> at least /etc. 
> > 
> > Read through my other postings, I said that things are private by
> > default.
> 
> So if I understand you correctly, you're saying you have a private /etc for 
> each instance of the sub-OS. Doesn't this make management of the system 
> a complete pig? And require modifying many user level tools?

My pay job is developing a distributed source management system which works
by replication.  We already have users who put all the etc files in it and
manage them that way.  Works great.  It's like rdist except it never screws
up and it has merging.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
