Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751619AbWGZNCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbWGZNCq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 09:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbWGZNCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 09:02:46 -0400
Received: from quechua.inka.de ([193.197.184.2]:38285 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751614AbWGZNCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 09:02:45 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060726112039.GA18329@merlin.emma.line.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1G5j2B-0005eW-00@calista.eckenfels.net>
Date: Wed, 26 Jul 2006 15:02:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I know thats not relevant for the discussion, but I wanted to share my
experiences anyway (to emphasis how important df-i monitoring on smaller
filesystems is):

Matthias Andree <matthias.andree@gmx.de> wrote:
> But the assertion that some backup was the cause for inode exhaustion on
> ext? is not very plausible since hard links do not take up inodes,
> symlinks are not backups and everything else requires disk blocks. So,
> since reformatting ext2/ext3 to one inode per block is possible
> (regardless of disk capacity), I see no way how a reformatted file
> system might run out of inodes before it runs out of blocks.

Well I had actually the problem on a tmpfs where I had too many zero byte
files...

Gruss
Bernd



> 
