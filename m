Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276564AbRI2Rie>; Sat, 29 Sep 2001 13:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276566AbRI2RiX>; Sat, 29 Sep 2001 13:38:23 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:7690 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S276564AbRI2RiT>; Sat, 29 Sep 2001 13:38:19 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: all files are executable in vfat
In-Reply-To: <E15n5ju-0008Uz-00@the-village.bc.nu>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 29 Sep 2001 19:37:55 +0200
In-Reply-To: <E15n5ju-0008Uz-00@the-village.bc.nu> (Alan Cox's message of "Fri, 28 Sep 2001 23:04:10 +0100 (BST)")
Message-ID: <tg7kuhsxsc.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > > Not for filesystems that store permission info, e.g., ext2,
> > > ISO9660+RockRidge, etc.
> > 
> > Sometimes I wish there was a uid/gid option for ext2, too.  (Doing
> > forensic analysis as root is a bit risky. ;-)
> 
> Usermode Linux can mount your ext2fs block device in the virtual linux,
> and with copy on write of changes to a different file.

Usermode Linux is indeed an option, thanks for the suggestions.

BTW, which of the journaling file systems support true read-only
mounts (without replaying the journal and thus writing to disk)?

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
