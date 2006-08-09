Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbWHIBdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbWHIBdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWHIBdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:33:35 -0400
Received: from relay1.ptmail.sapo.pt ([212.55.154.21]:23745 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1030399AbWHIBde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:33:34 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: ext3 corruption
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 02:33:31 +0100
Message-Id: <1155087211.4555.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man -k 2fs

man e2fsck

umount filesystem (don't forget it)
and e2fsck /dev/h (filesystem)

On Wed, 2006-08-09 at 01:47 +0200, Molle Bestefich wrote:
> I have a ~1TB filesystem that fails to mount, the message is:
> 
> EXT3-fs error (device loop0): ext3_check_descriptors: Block bitmap for
> group 2338 not in group (block 1607003381)!
> EXT3-fs: group descriptors corrupted !
> 
> A day before, it worked flawlessly.
> 
> What could have happened, and what's the best course of action?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

