Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbUBYB0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbUBYB0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:26:05 -0500
Received: from ns.suse.de ([195.135.220.2]:57531 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262567AbUBYBZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:25:56 -0500
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/mounts "stuff"
References: <Pine.LNX.4.53.0402241630500.4054@chaos>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I've gotta GO, now!!  I wanta tell you you're a GREAT bunch of guys
 but you ought to CHANGE your UNDERWEAR more often!!
Date: Wed, 25 Feb 2004 02:25:55 +0100
In-Reply-To: <Pine.LNX.4.53.0402241630500.4054@chaos> (Richard B. Johnson's
 message of "Tue, 24 Feb 2004 16:34:40 -0500 (EST)")
Message-ID: <je1xokeyqk.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> I think the two unusable entries should not show in
> /proc/mounts,
> 	rootfs / rootfs rw 0 0
> 	/dev/root / ext2 rw 0 0
> That would fix the problem because there is no way to
> umount either of them. Try it, `umount rootfs` returns
> ENOENT as does `umount /dev/root'`.

Since rootfs is a nodev filesystem the first column is an arbitrary
string, just like proc or devpts mounts.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
