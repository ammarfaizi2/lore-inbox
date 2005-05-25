Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVEYT44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVEYT44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 15:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbVEYT44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 15:56:56 -0400
Received: from animx.eu.org ([216.98.75.249]:1446 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261545AbVEYT4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 15:56:54 -0400
Date: Wed, 25 May 2005 15:54:06 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs
Message-ID: <20050525195406.GD1098@animx.eu.org>
Mail-Followup-To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	linux-kernel@vger.kernel.org
References: <20050525174135.GA1098@animx.eu.org> <20050525182613.GI23621@csclub.uwaterloo.ca> <20050525184542.GB1098@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050525184542.GB1098@animx.eu.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> Lennart Sorensen wrote:
> > I didn't know you could use CPIO archives as initrd images.  I have used
> > gzip'd ext2 and cramfs (on Debian kernels only so far).  Actually I
> > didn't know cpio was even considered a filesystem (and hence would be
> > difficult to mount at all).
> 
> Apparently, initrd is just a name and a buffer.  Whatever it does with it is
> a different story.  If the buffer looks like a cpio archive, it mounts tmpfs
> as / and populates it from the archive.  No ramdisk driver, no filesystem
> driver required.

Unfortunately, I noticed that the ramdisk driver has to be compiled in (I
didn't try w/o initrd support).  Atleast I dropped ext2 from my compiled in
list (NO filesystems in my kernel!)

Now it would be nice if I could remove rd from the compiled in list as well
(even thought it would only save a few K)

> Unfortunately for me, it doesn't work.  I'm still trying to figure out how
> it works.

As I stated earlier it now works.  error with my archive.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
