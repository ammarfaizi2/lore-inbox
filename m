Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbVIKLcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbVIKLcY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 07:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVIKLcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 07:32:24 -0400
Received: from main.gmane.org ([80.91.229.2]:3971 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932467AbVIKLcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 07:32:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [2.6-GIT] NTFS: Release 2.1.24.
Date: Sun, 11 Sep 2005 13:30:22 +0200
Message-ID: <1x6hosbphy3gb$.81ssbw0oah29.dlg@40tude.net>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk> <58obd5djrqk$.1nrux2jfwk0jg.dlg@40tude.net> <Pine.LNX.4.60.0509101424260.20200@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-ull-145-210.42-151.net24.it
User-Agent: 40tude_Dialog/2.0.15.1
Cc: linux-ntfs-dev@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2005 14:28:49 +0100 (BST), Anton Altaparmakov wrote:

> NTFS takes any.  It is happy with octal, decimal, and hex.  The ntfs 
> driver uses linux/lib/vsprintf.c::simple_strtoul() with a zero base which 
> autodetects which base to use so if you use umask=0222 it will take this 
> as octal and if you use umask=222 it will take this as decimal and if you 
> use 0x222 it will take this as decimal.

Uh. I was pretty sure I had tried the 0 prefix to get octal but it
failed, IIRC. Maybe I didn't run the test correctly, though.

> I do not see what is wrong with that.  It behaves exactly like I would 
> expect it to.  Maybe I have strange expectations?  (-;

I don't actually care one way or the other. I was just hoping for more
consistency across drivers :) This is why I went as far as suggesting
code sharing.

-- 
Giuseppe "Oblomov" Bilotta

"E la storia dell'umanità, babbo?"
"Ma niente: prima si fanno delle cazzate,
 poi si studia che cazzate si sono fatte"
(Altan)
("And what about the history of the human race, dad?"
 "Oh, nothing special: first they make some foolish things,
  then you study what foolish things have been made")

