Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312269AbSDEIAa>; Fri, 5 Apr 2002 03:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312256AbSDEIAV>; Fri, 5 Apr 2002 03:00:21 -0500
Received: from web20510.mail.yahoo.com ([216.136.226.145]:11787 "HELO
	web20510.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312269AbSDEIAK>; Fri, 5 Apr 2002 03:00:10 -0500
Message-ID: <20020405080008.77394.qmail@web20510.mail.yahoo.com>
Date: Fri, 5 Apr 2002 10:00:08 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: faster boots?
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ditto. Especially if it spun them down again
> when idle for a while.


I had a patch for this in my 2.2 kernel tree,
originally from wingel@ctrl-c.liu.se, but I
didn't have time to port it to 2.4. I've been
using it happily for about 2 years on the NFS
server which is too close to my bedroom. The
only annoying side of the problem is that when
you incidentelly do an NFS access and the disks
are down, you have to wait a few minutes before
they spin up, especially with raid. I once
failed a CD burning session from the NFS server
because doing something else simultaneously
woke other disks up, which hung the NFS server
until they were ready.

But it's definitely interesting, and missing
in 2.4 IMHO.

If you want to try it for your 2.2 tree, I
can send you the patch.

Cheers,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
