Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267609AbTBMBrM>; Wed, 12 Feb 2003 20:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267953AbTBMBrM>; Wed, 12 Feb 2003 20:47:12 -0500
Received: from rj.SGI.COM ([192.82.208.96]:60128 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S267609AbTBMBrK>;
	Wed, 12 Feb 2003 20:47:10 -0500
Message-ID: <3E4AFB3A.C6B0FBE0@sgi.com>
Date: Wed, 12 Feb 2003 17:56:10 -0800
From: Casey Schaufler <casey@sgi.com>
Organization: Silicon Graphics
X-Mailer: Mozilla 4.8 [en] (X11; U; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: "'Christoph Hellwig'" <hch@infradead.org>
CC: Crispin Cowan <crispin@wirex.com>, torvalds@transmeta.com,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
       "Makan Pourzandi (LMC)" <Makan.Pourzandi@ericsson.ca>,
       linux-security-module@wirex.com, magniett <Frederic.Magniette@lri.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: What went wrong with LSM, was: Re: [BK PATCH] LSM changes for 2.5.59
References: <7B2A7784F4B7F0409947481F3F3FEF8305CC954F@eammlex037.lmc.ericsson.se>
		<3E4A9C4D.F580576E@lri.fr> <20030212183812.A14810@infradead.org>
		<3E4AC92A.4020705@wirex.com> <20030212230550.A19831@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'Christoph Hellwig' wrote:

> And here we see _the_ problem with the LSM process.

I personally don't agree with the subject line,
as I don't believe that anything "went wrong" with
LSM. True, it's not what I want, but then my contribution
wasn't what it needed to be to make it such, either.
I often disagreed with the directions, and was sometimes
surprised, but that kind of thing happens in a large
group environment. My sage wisdom was considered
more often than not, even if it was discarded unused
from time to time.

I've been retrofitting security policy into U2X systems
since the 1980's, first Orange Book and now Common
Criteria, and it's HARD. LSM is a fine first whack.
No one should dispair that it fails to meet a particular
need exactly, or that those meany maintainers won't
accept your hook without seeing the code that uses it.
Alan Cox described the Linux development process as
climbing over a fence with everyones hands in each others
pockets, and I think that describes LSM pretty well.

Advanced security features are unpopular, and
all evidience points to them remaining so. We, as
a development community, have yet to convince the
great insecure masses that they want to see audit
trails, user clearances, and time of day controls
in "their" kernels. Heck, we have yet to convince
each other! But buck up, I fully expect we'll do
better next round, and better the time after that,
as well.

LSM isn't finished because Linux isn't finished
and as a group we security developers are a
tenacious (stubborn? pig headed maybe?) lot.

-- 

Casey Schaufler				Manager, Trust Technology, SGI
casey@sgi.com				voice: 650.933.1634
casey_p@pager.sgi.com			Pager: 877.557.3184
