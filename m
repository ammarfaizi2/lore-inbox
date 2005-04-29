Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262877AbVD2Sdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbVD2Sdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 14:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbVD2Sdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 14:33:55 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:46791 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262877AbVD2Sdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 14:33:50 -0400
Message-ID: <2712.10.10.10.24.1114799620.squirrel@linux1>
In-Reply-To: <200504291808.LAA25870@emf.net>
References: <Pine.LNX.4.58.0504291051460.18901@ppc970.osdl.org> (message from
    Linus Torvalds on Fri, 29 Apr 2005 10:56:30 -0700 (PDT))
    <200504291808.LAA25870@emf.net>
Date: Fri, 29 Apr 2005 14:33:40 -0400 (EDT)
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
From: "Sean" <seanlkml@sympatico.ca>
To: "Tom Lord" <lord@emf.net>
Cc: torvalds@osdl.org, mpm@selenic.com, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, April 29, 2005 2:08 pm, Tom Lord said:

> The confusion here is that you are talking about computational complexity
> while I am talking about complexity measured in hours of labor.
>
> You are assuming that the programmer generating the signature blindly
> trusts the tool to generate the signed document accurately.   I am
> saying that it should be tractable for human beings to read the documents
> they are going to sign.


Developers obviously _do_ read the changes they submit to a project or
they would lose their trusted status.  That has absolutely nothing to do
with signing, it's the exact same way things work today, without sigs.

It's not "blind trust" to expect a script to reproducibly sign documents
you've decided to submit to a project.  The signature is not a QUALITY
guarantee in and of itself.  It doesn't mean you have any additional
responsibility to remove all bugs before submitting.  Conversely, not
signing something doesn't mean you can submit crap.

See?  Signing something does not change the quality guarantee one way or
the other.  It does not put any additional demands on the developer, so
it's fine to have an automated script do it.  It's just a way to avoid
impersonations.

Sean

