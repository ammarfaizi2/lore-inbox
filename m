Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266145AbUA1U61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 15:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266158AbUA1U61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 15:58:27 -0500
Received: from virt-216-40-198-21.ev1servers.net ([216.40.198.21]:17158 "EHLO
	virt-216-40-198-21.ev1servers.net") by vger.kernel.org with ESMTP
	id S266145AbUA1U6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 15:58:24 -0500
Date: Wed, 28 Jan 2004 14:58:10 -0600
From: Chuck Campbell <campbell@accelinc.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.2 kernel and ext3 filesystems
Message-ID: <20040128205810.GA8287@helium.inexs.com>
Reply-To: campbell@accelinc.com
Mail-Followup-To: Chuck Campbell <campbell@accelinc.com>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
References: <20040124033208.GA4830@helium.inexs.com> <20040123215848.28dac746.akpm@osdl.org> <20040126145633.GA26983@helium.inexs.com> <20040126124141.6b6b84ba.akpm@osdl.org> <20040127012717.GA19704@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127012717.GA19704@thunk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 08:27:17PM -0500, Theodore Ts'o wrote:
> 
> There were also some bug fixes that I'm pretty sure were never
> backported into the 2.2 tree....

I may be being stung by this as we speak.

I mounted this ext3 filesystem as ext2 on my 2.2.16 kernel system. I made 
some changes to some files (simple edits), and now when I reboot the box in
2.2.16, I get the following:

mount: wrong fs type, bad option, bad superblock on /dev/hdb2,
       or too many mounted filesystems

in /var/log/messages I see:
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
EXT2-fs: ide0(3,66): couldn't mount because of unsupported optional features.


I'm reticent to run any e2fsck as old as 2.2.16 kernel version against
this filesystem, in fear of damaging it.  Is this a sane thing to consider,
or do I need to put this disk back into a more recent box and try to mount it/
fsck it there?

Alternatively, where might I dig up an ext3 patch against linux-2.2.x, so
I can build a kernel that will support this?  I assume I would need file
utilities that support it as well?

thanks,
-chuck


-- 
