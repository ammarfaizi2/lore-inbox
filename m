Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbTEMVWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263437AbTEMVVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:21:41 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:10746 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262454AbTEMVVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:21:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Chuck Ebbert <76306.1226@compuserve.com>,
       Yoav Weiss <ml-lkml@unpatched.org>
Subject: Re: The disappearing sys_call_table export.
Date: Tue, 13 May 2003 16:32:48 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
References: <200305131048_MC3-1-38B1-E13F@compuserve.com>
In-Reply-To: <200305131048_MC3-1-38B1-E13F@compuserve.com>
MIME-Version: 1.0
Message-Id: <03051316324801.20373@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 May 2003 09:45, Chuck Ebbert wrote:
> Jesse Pollard wrote:
> > > However, it'll just give you false sense of security.  First of all,
> > > its hardware dependent.  Second, it won't get wipe in case of a crash
> > > (which is likely to happen when They come to take your disk).
> >
> > It is also not a valid wipe either.
> >
> > This particular object reuse assumes the hardware is in a secured area.
> > If it is in a secured area then you don't need to wipe it. It remains
> > completely under the systems control (even during a crash and reboot).
> > The interval between crash and reboot is covered by the requirement to be
> > in a secured area.
>
>   ...until the admin walks in, shuts down the system, puts it on a cart
> and hauls it out the door.  Is he going to wipe the swap area before he
> does that?  Sure, you can write a procedure that says that's what he does
> but he will not follow it (been there done that.)

If you are in that situation, the what keeps him from just pulling the plug...
Again, the swap doesn't get purged.

If you are in a situation where swap must be purged (as I am) then you also
know you can't just walk out the door with the system. There must be property
passes, security passes, AND inventory documents that must also show the
contents of the purged disks... signed off by the information security
officer.
