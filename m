Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbSKCBAH>; Sat, 2 Nov 2002 20:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261542AbSKCBAH>; Sat, 2 Nov 2002 20:00:07 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:56459 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261541AbSKCBAB>; Sat, 2 Nov 2002 20:00:01 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, "Theodore Ts'o" <tytso@mit.edu>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <Pine.LNX.4.44.0211021619580.2221-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211021619580.2221-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 01:27:20 +0000
Message-Id: <1036286840.18289.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 00:22, Linus Torvalds wrote:
> 
> On Sat, 2 Nov 2002, Rik van Riel wrote:
> > 
> > Sure it's more flexible, but I wonder how many userland
> > programs will be broken if we change the permission model
> > and how well users can protect their data this way.
> 
> This is not a "change". Existing behaviour clearly cannot change. We're 
> talking about new interfaces to export capabilities in the filesystem.

So you are talking about a new interface that sucks. Slight difference
in situation no difference in result. At the point where link/rename and
even NFS happenings on remote boxes may get involved I don't want to go
anywhere near it. One thing Unix actually got right from the beginning
is that rights belong to objects not to names. Name based labelling has
never worked in or out of computing.

What you are suggesting is the equivalent of marking documents 'secret'
by putting them in a specific drawer and hoping nobody ever misfiles it.
Everyone instead writes "secret" on the document - guess why

