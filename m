Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273666AbRIWWdx>; Sun, 23 Sep 2001 18:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273665AbRIWWdp>; Sun, 23 Sep 2001 18:33:45 -0400
Received: from t2.redhat.com ([199.183.24.243]:46585 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S273663AbRIWWdi>; Sun, 23 Sep 2001 18:33:38 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@cambridge.redhat.com>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Sep 2001 23:34:02 +0100
Message-ID: <16995.1001284442@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
> In addition to the VM changes that have gotten so much attention there
> are architecture updates, various major filesystem updates (jffs2 and
> NTFS),

JFFS2 can't actually be built at the moment because the magic in 
fs/Makefile and fs/Config.in appears to be absent. The fix for that is
about number 20 in the patchbomb I'm currently preparing.

The terminally impatient can find the whole patch, before I finish removing 
some of the backward-compatibility crap, at 
	ftp.uk.linux.org:/pub/people/dwmw2/mtd/mtd-diff-against-2.4.10-v2

--
dwmw2


