Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWGZL0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWGZL0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWGZL0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:26:48 -0400
Received: from mail.gmx.net ([213.165.64.21]:28879 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751061AbWGZL0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:26:46 -0400
X-Authenticated: #428038
Date: Wed, 26 Jul 2006 13:26:44 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: David Masover <ninja@slaphack.com>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060726112644.GB18329@merlin.emma.line.org>
Mail-Followup-To: David Masover <ninja@slaphack.com>,
	LKML <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <200607242151.k6OLpDZu009297@laptop13.inf.utfsm.cl> <200607251708.13660.vda.linux@googlemail.com> <20060725204910.GA4807@merlin.emma.line.org> <44C6A390.2040001@slaphack.com> <20060726112039.GA18329@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726112039.GA18329@merlin.emma.line.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Matthias Andree wrote:

> But the assertion that some backup was the cause for inode exhaustion on
> ext? is not very plausible since hard links do not take up inodes,
> symlinks are not backups and everything else requires disk blocks. So,
> since reformatting ext2/ext3 to one inode per block is possible
> (regardless of disk capacity), I see no way how a reformatted file
> system might run out of inodes before it runs out of blocks.

OK; ext2/ext3 require 1k blocks, but still you need heaps of files < 1k
to run out of inodes without running of space.

-- 
Matthias Andree
