Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261707AbTCGRIh>; Fri, 7 Mar 2003 12:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261743AbTCGRIh>; Fri, 7 Mar 2003 12:08:37 -0500
Received: from air-2.osdl.org ([65.172.181.6]:32161 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261707AbTCGRIc>;
	Fri, 7 Mar 2003 12:08:32 -0500
Date: Fri, 7 Mar 2003 09:17:20 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: aia21@cantab.net, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
Message-Id: <20030307091720.6b71268c.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.30.0303070845130.32-100000@divine.city.tvnet.hu>
References: <32995.4.64.238.61.1047023411.squirrel@www.osdl.org>
	<Pine.LNX.4.30.0303070845130.32-100000@divine.city.tvnet.hu>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003 08:52:42 +0100 (MET) Szakacsits Szabolcs <szaka@sienet.hu> wrote:

| 
| On Thu, 6 Mar 2003, Randy.Dunlap wrote:
| 
| > I tried to decode the disassembly, got lots of it done,
| > but I bogged down on something that may be outside of the
| > NTFS realm.  I have ALL kernel hacking options enabled
| > (=y), and it's a bit hairy (for me) to decode all of the
| > extra/added code, and this may be where the oops is
| > happening.  Dunno really, just wanted to warn you.
| 
| This was one of the issues I suspected (lots of hacking option) and
| asked for .config also. Your __ntfs_init_inode was *huge* and the oops
| Code didn't resembled to any of written in __ntfs_init_inode ...
| unless you have some hardware issue (bit flips, memory/CPU, etc). When
| I have time I'll also take a closer look. I don't exclude some
| alignment issues either ...

BTW, I think that this would be a reasonable reason (huh?) to dismiss
this bug against NTFS -- i.e., if it's found to be a problem in general
kernel debug helpers.  Still be nice to find where it happened,
of course.

--
~Randy
