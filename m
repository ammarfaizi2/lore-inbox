Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279509AbRKMWE0>; Tue, 13 Nov 2001 17:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279596AbRKMWEK>; Tue, 13 Nov 2001 17:04:10 -0500
Received: from demai05.mw.mediaone.net ([24.131.1.56]:50636 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S279509AbRKMWDg>; Tue, 13 Nov 2001 17:03:36 -0500
Message-Id: <200111132203.fADM3jW03006@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: File server FS?
Date: Tue, 13 Nov 2001 17:03:34 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are about to build a fairly large (720GB) file server using Linux.  No 
sane person would actually want to watch this thing fsck, but I've seen 
mixed reports about the functionality of the journaled FSes.

Specifically, I need support for
 * KNFSD - it is a file server, afterall
 * LVM - For snapshots and to add space later
 * Resizing - See last point
 * Quotas - Eventually, but we don't need it just yet

Which, if any, of the journaled FSes support these?
Which one should I go with for a wide range of file and directory sizes?

I have no desire to wipe and restore 720GB of data, so we're pretty much 
stuck with what we launch with.

Thanks
	-- Brian
