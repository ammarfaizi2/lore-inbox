Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267937AbTBSD1i>; Tue, 18 Feb 2003 22:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267935AbTBSD1i>; Tue, 18 Feb 2003 22:27:38 -0500
Received: from ns1.mountaincable.net ([24.215.0.11]:3490 "EHLO
	ns1.mountaincable.net") by vger.kernel.org with ESMTP
	id <S267937AbTBSD1K>; Tue, 18 Feb 2003 22:27:10 -0500
Subject: linux 2.5: crypto core + block devices + ???
From: desrt <desrt@desrt.ca>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1045625825.2879.8.camel@nothing.desrt.ca>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1- 
Date: 18 Feb 2003 22:37:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've recently been poking around the 2.5 source tree.  I've noticed that
we now have crypto built into the stock kernel distribution (good).  The
loopback driver doesn't appear to support using the crypto API though.
(bad)

Looking at the way the crypto api works (ie: skatterlists) makes it seem
vaguely compatible with what I've read about the new block device IO
mechanisms in 2.5.  Is this an accident?  Is there some generic crypto
support for block devices planned that will obsolete using the loopback
driver to this end? (like the pages get decrypted upon loading into the
buffer cache from the physical media or whatever? i'm not really sure
how all the block device stuff works,...)

If there are no deeper motives here and the intention is to continue
supporting encrypted filesystems via the loopback interface, is there
anyone working on the project?  It seems a little bit slow (or
uncertain) with respects to the 2.5 kernels.  If somebody is needed to
write some code, I'd be willing to write a loopback transfer function to
interact with the crypto core.  (I'd have no idea where to start for the
generic block device crypto ramblings mentioned above...)

Anyway.. thanks in advance.  Please CC replies to my address as I'm not
a list member.
Ryan

