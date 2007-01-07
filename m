Return-Path: <linux-kernel-owner+w=401wt.eu-S932549AbXAGOaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbXAGOaf (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 09:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbXAGOaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 09:30:35 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:51609 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932549AbXAGOae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 09:30:34 -0500
Date: Sun, 07 Jan 2007 23:30:31 +0900 (JST)
Message-Id: <20070107.233031.74752430.anemo@mba.ocn.ne.jp>
To: phillip@lougher.demon.co.uk
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ralf@linux-mips.org
Subject: Re: [announce] Squashfs 3.2 released
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <A1EA4789-E143-43C8-BBDC-0935EFA470A1@lougher.demon.co.uk>
References: <A1EA4789-E143-43C8-BBDC-0935EFA470A1@lougher.demon.co.uk>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2007 05:33:53 +0000, Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
>         6. Odd behaviour of MIPS memcpy in read_data() routine worked- 
> around.

It is for PREFETCH issue reported on this mail, right?
http://sourceforge.net/mailarchive/message.php?msg_id=37687166

MIPS memcpy is no longer abuse PREFETCH.  The "fix" was done on Oct
2005.  So if the "workaround" had any bad side effects, it can be
reverted.

---
Atsushi Nemoto
