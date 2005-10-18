Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVJRVnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVJRVnx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 17:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVJRVnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 17:43:53 -0400
Received: from relais.videotron.ca ([24.201.245.36]:2623 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932153AbVJRVnw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 17:43:52 -0400
Date: Tue, 18 Oct 2005 17:43:35 -0400
From: Jeff Bailey <jbailey@ubuntu.com>
Subject: Re: Keep initrd tasks running?
In-reply-to: <43554F1C.9090901@comcast.net>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org, ubuntu-devel <ubuntu-devel@lists.ubuntu.com>
Message-id: <1129671815.18784.115.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution 2.4.1
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 8BIT
References: <4355494C.5090707@comcast.net>
 <1129663759.18784.98.camel@localhost.localdomain>
 <43554F1C.9090901@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 18 octobre 2005 à 15:38 -0400, John Richard Moser a écrit :
> > This is much more easily supported in Breezy.  usplash is started at the
> > top of the initramfs (from the init-top hook) and lives until we start
> > gdm.

> So in short it's possible?
I make no promises until I"m holding the code in my hand and have tested
it myself. =)  I don't see any reason why it wouldn't work.

> That's not much of a problem for me.  What I'm contemplating is a FUSE
> file system driver that gets started in the initrd, and a kernel that
> has a file system driver built-in for something stupid like cramfs or MINIX.

Ah, okay.  Jerry Haltom was looking at how to support booting from a
loopback filesystem (for embedded systems shiping a .bin blob) and he
was able to get it running.  This is hopefully just another twist on the
same thing.  I haven't played with FUSE, though, so I don't know what's
needed.

Lemme know if you run into specific problems.  If you have access to
IRC, I'm on freenode as jbailey in #ubuntu-devel.

Tks,
Jeff Bailey

