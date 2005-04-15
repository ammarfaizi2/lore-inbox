Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVDOUEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVDOUEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 16:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVDOUEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 16:04:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:65423 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261592AbVDOUEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 16:04:07 -0400
Date: Fri, 15 Apr 2005 13:03:56 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Igor Shmukler <igor.shmukler@gmail.com>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: intercepting syscalls
Message-Id: <20050415130356.5d99856f.rddunlap@osdl.org>
In-Reply-To: <6533c1c905041512411ec2a8db@mail.gmail.com>
References: <6533c1c905041511041b846967@mail.gmail.com>
	<1113588694.6694.75.camel@laptopd505.fenrus.org>
	<6533c1c905041512411ec2a8db@mail.gmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005 15:41:34 -0400 Igor Shmukler wrote:

| Hello,
| 
| Thanks to everyone for replying.
| It is surprising to me that linux-kernel people decided to disallow
| interception of system calls.
| I don't really see any upside to this.

Upside ?

| I guess if there is no clean way to do this, we will have to resort to
| quick and dirty.
| 
| Can anyone point to a discussion that yielded this decision. Perhaps,
| I need to educate myself. I stumbled upon comments that this can lead
| to mess, but pretty much anything in LKM can cause problems. I don't
| think that hiding commonly used convenient interfaces just because
| they can be abused is a valid reason, hence I would love to know what
| is the real reason.

What "commonly used convenient interfaces"?


I don't claim to remember all of the reasons.  A couple of them are:

a.  it's racy
b.  it's not architecture-independent


| Thank you,
| 
| Igor
| 
| 
| On 4/15/05, Arjan van de Ven <arjan@infradead.org> wrote:
| > On Fri, 2005-04-15 at 14:04 -0400, Igor Shmukler wrote:
| > > Hello,
| > > We are working on a LKM for the 2.6 kernel.
| > > We HAVE to intercept system calls. I understand this could be
| > > something developers are no encouraged to do these days, but we need
| > > this.
| > 
| > your module is GPL licensed right ? (You're depending on deep internals
| > after all)
| > 
| > Why do you *have* to intercept system calls... can't you instead use the
| > audit infrastructure to get that information ?
| > 
| > What is the URL of your current code so that we can provide reasonable
| > recommendations ?
| -


---
~Randy
