Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262594AbTCITuy>; Sun, 9 Mar 2003 14:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262595AbTCITux>; Sun, 9 Mar 2003 14:50:53 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:2824 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262594AbTCITuw>; Sun, 9 Mar 2003 14:50:52 -0500
Date: Sun, 9 Mar 2003 21:01:19 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Zack Brown <zbrown@tumblerings.org>, Larry McVoy <lm@work.bitmover.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
In-Reply-To: <Pine.LNX.4.44.0303090928570.11894-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303091918110.5042-100000@serv>
References: <Pine.LNX.4.44.0303090928570.11894-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Mar 2003, Linus Torvalds wrote:

> The distribution is absolutely fundamental, and _the_ reason why I use BK.

I agree, that this is an important aspect and for your kind of work it's 
absolutely necessary.
But source management is more than just distributing and merging changes. 
E.g. if I want to develop a driver, I would start like most people from a 
stable base, that means 2.4. At a certain point the development splits 
into a development and stable branch, eventually I also want to merge my 
driver into the 2.5 tree.
This means I have to deal with 5 different source trees (branches), two 
branches track external trees and I want to know what has been merged from 
my development into my 2.4 and 2.5 stable branches, which I can use to 
make official releases. I want to be able to push multiple changes as a 
single change into the stable branches and it should be able to tell me 
which changes are still left.
If there would be a free SCM system, which could do this, I could easily 
do without a distributed option. Although I think as soon as it would be 
this far it should be relatively easy to add a distribution mechanism (by 
using a separate branch, which is only used for pulling changes). OTOH I 
suspect that it will be very hard to add the other capabilities to bk 
without a major redesign, as it's not a simple hierarchic structure 
anymore.

bye, Roman

