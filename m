Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278275AbRJVIdP>; Mon, 22 Oct 2001 04:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278086AbRJVIdF>; Mon, 22 Oct 2001 04:33:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33232 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278062AbRJVIcy>;
	Mon, 22 Oct 2001 04:32:54 -0400
Date: Mon, 22 Oct 2001 04:33:27 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12 
In-Reply-To: <23837.1003738907@kao2.melbourne.sgi.com>
Message-ID: <Pine.GSO.4.21.0110220423230.2294-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Oct 2001, Keith Owens wrote:

> When the post-install and pre-remove entries for module binfmt_misc are
> hard coded into modprobe, there is no syntax in modules.conf to prevent
> modprobe from always issuing those commands.  The next time somebody
> decides that binfmt_misc needs different commands, everybody using the
> old modutils on the new kernel will break.  I don't want the hassle,
> put it in modules.conf where it can easily be changed.
> 
> If I can get an iron clad guarantee that binfmt_misc will never, ever
> change again then I might consider hard coding the entries in modprobe.
> BTW, I will need a signature in blood that says I can kill you if
> binfmt_misc is ever changed :).

Wait a second.  Who says anything about hardcoding that into modprobe?
There is such thing as skeleton stuff for modules.conf, right?

