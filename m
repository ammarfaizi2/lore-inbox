Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263501AbTI2PAo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbTI2PAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:00:44 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:32417 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263501AbTI2PAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:00:43 -0400
Date: Mon, 29 Sep 2003 17:00:05 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] check headers for complete includes, etc.
Message-ID: <20030929150005.GA24375@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <20030928184642.GA1681@mars.ravnborg.org> <20030928191622.GA16921@wohnheim.fh-wedel.de> <20030928193150.GA3074@mars.ravnborg.org> <20030928194431.GB16921@wohnheim.fh-wedel.de> <20030929133624.GA14611@wohnheim.fh-wedel.de> <20030929145057.GA1002@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030929145057.GA1002@mars.ravnborg.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 September 2003 16:50:57 +0200, Sam Ravnborg wrote:
> On Mon, Sep 29, 2003 at 03:36:24PM +0200, Jörn Engel wrote:
> > First version of the script.  Seems to work, but it catches a lot,
> > maybe too much.
> 
> What about adding a negative list, so headerfiles that we decide
> shall not be able to compile stand-alone are filtered away.
> But new headers are added.

Would work.  But I'd prefer to have that information inside the header
files, under some syntax.

/* attr: indirect header */

Is this acceptable?

Jörn

-- 
Happiness isn't having what you want, it's wanting what you have.
-- unknown
