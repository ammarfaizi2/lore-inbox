Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282815AbRLBIHk>; Sun, 2 Dec 2001 03:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282813AbRLBIHa>; Sun, 2 Dec 2001 03:07:30 -0500
Received: from smtp-abo-3.wanadoo.fr ([193.252.19.152]:59296 "EHLO
	andira.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S282828AbRLBIHK>; Sun, 2 Dec 2001 03:07:10 -0500
Message-ID: <3C09E0BC.16A957DE@wanadoo.fr>
Date: Sun, 02 Dec 2001 09:05:16 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
		<9u9qas$1eo$1@penguin.transmeta.com>
		<200112010701.fB171N824084@vindaloo.ras.ucalgary.ca>
		<3C0898AD.FED8EF4A@wanadoo.fr>
		<200112011836.fB1IaxY31897@vindaloo.ras.ucalgary.ca>
		<3C093F86.DA02646D@wanadoo.fr> <200112012320.fB1NKro03024@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:


> I assume if you use kernel 2.4.16 with devfsd-1.3.20 that there is no
> Oops?

2.4.16 not patched, with debug options below, is booting nicely with
devfsd-v1.3.18 or devfsd-v1.3.20. I don't succeed to reproduce the
problem with rxvt nor xterm.

CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVFS_DEBUG=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_BUGVERBOSE=y

Pierre
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
