Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285023AbRLRU1D>; Tue, 18 Dec 2001 15:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285043AbRLRU04>; Tue, 18 Dec 2001 15:26:56 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32689 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285023AbRLRU0g>;
	Tue, 18 Dec 2001 15:26:36 -0500
Date: Tue, 18 Dec 2001 15:26:34 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
Subject: RE: Booting a modular kernel through a multiple streams file
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D804@orsmsx111.jf.intel.com>
Message-ID: <Pine.GSO.4.21.0112181508270.7996-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Dec 2001, Grover, Andrew wrote:

> I'm not arguing that the new initrd won't be better than the old initrd
> (because obviously you are right) I'm arguing that no matter how whizzy
> initrd is, it's still an unnecessary step, and it's one that other OSs (e.g.
> FreeBSD) omit in favor of the approach I'm advocating.

Learn to read.  You don't _have_ to have initrd.  At all.  There's nothing
to stop your loader from putting whatever cpio archive it likes - it
doesn't involve anything other than slapping files you want together
putting their owner/group/size/timestamps/mode/name before each of them.
Anything that puts a bunch of modules in core will have to do equivalent
job.

