Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131376AbRC0QYx>; Tue, 27 Mar 2001 11:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131393AbRC0QYp>; Tue, 27 Mar 2001 11:24:45 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20499 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131395AbRC0QY0>; Tue, 27 Mar 2001 11:24:26 -0500
Subject: Re: "mount -o loop" lockup issue
To: dek_ml@konerding.com (David Konerding)
Date: Tue, 27 Mar 2001 17:25:46 +0100 (BST)
Cc: riel@conectiva.com.br (Rik van Riel), linux-kernel@vger.kernel.org
In-Reply-To: <3AC04BAC.C21E302@konerding.com> from "David Konerding" at Mar 27, 2001 12:13:32 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14hwI1-0003sV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's even worse that these are obvious, simple bugs (like the "NFS doesn't
> work over reiserfs
> because somebody changed the VFS layer and didn't fix any filesystems but
> ext2" that I reported a while ago) which would have been caught by a
> little testing.

Again people knew about this. It was a chosen decision that 2.4.x shouldnt
support NFS over reiserfs.  If you want an extensively QA'd, signed off
kernel tree then wait for vendors to release one.

Alan

