Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbTJSVwF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 17:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTJSVwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 17:52:05 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:3207 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S262071AbTJSVwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 17:52:03 -0400
Message-ID: <34569.192.168.9.10.1066600317.squirrel@ncircle.nullnet.fi>
In-Reply-To: <24673.1066593435@www23.gmx.net>
References: <24673.1066593435@www23.gmx.net>
Date: Mon, 20 Oct 2003 00:51:57 +0300 (EEST)
Subject: Re: HighPoint 374
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: "Svetoslav Slavtchev" <svetljo@gmx.de>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> i have the same problems with epox 8k9a3+,
> and may be even strange ones
> (like fs coruption when soft raid & / or lvm is used)

I've seen the filesystem corruption with ext3 & xfs
and RAID1 (md) as well. However, I don't seem to
be able to get that far nowadays, as the machine
is being used as NFS-server and thefore there is
always "too much" disk-transfers going on and an
IDE-system hang happens quite soon after boot.
(it seems that my raid-disks get out of sync every time
I switch from proprietary driver --> kernel driver
and so it might be the raid resync that hangs the system).

> and i never had the problems with 8k5a3+,
> the drives were actually taken from the 8k5a3+
> when it died (me silly tried to update to XP2700)
>
> really strange, isn't it
>
> both boards should be the same, except
> 8k5a3+ uses kt333
> 8k9a3+ uses kt400

Yep, but it cannot be strictly via-chipset issue
as I have verified that the same problem exists
with Epox 4PCA3+ motherboard, which is P4 & Intel 875P
based.


