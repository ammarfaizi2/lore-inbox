Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265811AbUADWBN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 17:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUADWBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 17:01:12 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:16142 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265811AbUADWBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 17:01:09 -0500
Date: Sun, 4 Jan 2004 23:01:04 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040104230104.A11439@pclin040.win.tue.nl>
References: <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401022033010.10561@home.osdl.org> <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401041302080.2162@home.osdl.org>; from torvalds@osdl.org on Sun, Jan 04, 2004 at 01:05:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 01:05:20PM -0800, Linus Torvalds wrote:

> Oh, _I_ always understood. You were the one that was arguing for
> stable numbers as somehow important.

Indeed. I said "preferably stable across reboots".

> I'm just telling you that they aren't stable, and that a
> user application that depends on their stability or
> their uniqueness is BROKEN.

Surprise! Are you leaving POSIX? Or ditching NFS?
Or demanding that NFS servers must never reboot?

A common Unix idiom is testing for the identity
of two files by comparing st_ino and st_dev.
A broken idiom?

No idea what part of our Unix heritage you now have decided to call broken.

Andries


