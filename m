Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267724AbTASXsm>; Sun, 19 Jan 2003 18:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267723AbTASXsm>; Sun, 19 Jan 2003 18:48:42 -0500
Received: from mail.webmaster.com ([216.152.64.131]:13551 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S267722AbTASXsl> convert rfc822-to-8bit; Sun, 19 Jan 2003 18:48:41 -0500
From: David Schwartz <davids@webmaster.com>
To: <adilger@clusterfs.com>, Roman Zippel <zippel@linux-m68k.org>
CC: Larry McVoy <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Sun, 19 Jan 2003 15:57:40 -0800
In-Reply-To: <20030119162614.I1594@schatzie.adilger.int>
Subject: Re: Is the BitKeeper network protocol documented?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030119235742.AAA13049@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2003 16:26:14 -0700, Andreas Dilger wrote:

>There is nothing in the GPL which requires anyone to make their
>changes
>available to you the minute they make them.  The fact that you have
>access
>to the changes within an hour of when they are made far exceeds the
>requirements in the GPL, which only require that the source code be
>made
>available if you distribute the OBJECT CODE OR EXECUTABLE.

	I think you're ignoring the way the GPL defines the "source code". 
The GPL defines the "source code" as the preferred form for modifying 
the program. If the preferred form of a work for purposes of 
modifying it is live access to a BK repository, then that's the 
"source code" for GPL purposes.

>There
>are still lots of other ways to get the kernel source.

	You are using the conventional meaning of "source code", which is 
roughly, "whatever you compile to get the executable". However, this 
is not the "source" for GPL purposes. For GPL purposes, the source is 
the preferred form of a work for purposes of modifying it.

	This means you can't remove meta information that's useful for 
modifying because that is not the preferred form. Such meta 
information includes whatever is useful for modifying it, such as 
revision history and chain of custody.

	You can't have two "source"s, one a private repository that you 
prefer to use for making changes and the other an "obfuscated" public 
version you distribute for GPL compliance which is missing all the 
other useful information.

	Checking source out of a repository, separating away the revision 
history, is an obfuscatory act. The GPL prohibits such source 
obfuscation and requires you to distribute the source in whatever is 
the actual preferred form for modifying it. Really. Sorry.

	DS


