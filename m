Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbTI2OvD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 10:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbTI2OvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 10:51:02 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:1029 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263484AbTI2OvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 10:51:00 -0400
Date: Mon, 29 Sep 2003 16:50:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] check headers for complete includes, etc.
Message-ID: <20030929145057.GA1002@mars.ravnborg.org>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Jamie Lokier <jamie@shareable.org>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <20030928184642.GA1681@mars.ravnborg.org> <20030928191622.GA16921@wohnheim.fh-wedel.de> <20030928193150.GA3074@mars.ravnborg.org> <20030928194431.GB16921@wohnheim.fh-wedel.de> <20030929133624.GA14611@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030929133624.GA14611@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 03:36:24PM +0200, Jörn Engel wrote:
> First version of the script.  Seems to work, but it catches a lot,
> maybe too much.

What about adding a negative list, so headerfiles that we decide
shall not be able to compile stand-alone are filtered away.
But new headers are added.

	Sam
