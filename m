Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266813AbUIJKYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbUIJKYH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 06:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267234AbUIJKYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 06:24:07 -0400
Received: from the-village.bc.nu ([81.2.110.252]:60078 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266813AbUIJKYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 06:24:03 -0400
Subject: Re: silent semantic changes in reiser4 (brief attempt to document
	the idea ofwhat reiser4 wants to do with metafiles and why
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hans Reiser <reiser@namesys.com>
Cc: Paul Jakma <paul@clubi.ie>, "Theodore Ts'o" <tytso@mit.edu>,
       Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       William Stearns <wstearns@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <414135E6.8050103@namesys.com>
References: <41323AD8.7040103@namesys.com> <413E170F.9000204@namesys.com>
	 <Pine.LNX.4.58.0409071658120.2985@sparrow>
	 <200409080009.52683.robin.rosenberg.lists@dewire.com>
	 <20040909090342.GA30303@thunk.org> <4140ABB6.6050702@namesys.com>
	 <Pine.LNX.4.61.0409092136160.23011@fogarty.jakma.org>
	 <4140FBE7.6020704@namesys.com>
	 <Pine.LNX.4.61.0409100212080.23011@fogarty.jakma.org>
	 <414135E6.8050103@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094808053.17029.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 10:20:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 06:04, Hans Reiser wrote:
> > Just one of many applications. Watch Joe-user save their word 
> > processing file sometime, they'll use spaces, quotes, etc.
> With great unhappiness they will.

Its only problematic for the command line users. The GUI doesn't have
some mysterious notion of meta-characters, it provides out of band
information on boundaries.

> This is why I just want to be left alone to tinker with reiser4. It is 
> faster than other filesystems. People should assume I know what I am 
> doing, and leave me to tinker in my little fs. 5 years later others will 
> follow, or not, I don't care.

See I don't care if you tinker with reiser4. I don't care if it turns
out to be a crap fs or a great fs. If its a great fs and scales and
unlike reiser3 can recover well from disk errors then one year I might
even use it.

I do care if you ask me to suffer core API changes for your research,
that in your economics world is an externality. Its a large negative
externality on the part of the userbase so the userbase objects. It
doesn't take a PhD in economics to understand this.

Alan

