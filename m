Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319193AbSHTQwi>; Tue, 20 Aug 2002 12:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319195AbSHTQwi>; Tue, 20 Aug 2002 12:52:38 -0400
Received: from smtp4.vol.cz ([195.250.128.43]:23566 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S319193AbSHTQwi>;
	Tue, 20 Aug 2002 12:52:38 -0400
Date: Tue, 20 Aug 2002 13:09:10 +0200
From: Stanislav Brabec <utx@penguin.cz>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: Andre Hedrick <andre@linux-ide.org>, Paul Bristow <paul@paulbristow.net>,
       linux-kernel@vger.kernel.org
Subject: Re: ide-floppy & devfs - /dev entry not created if drive is empty
Message-ID: <20020820110910.GB2831@utx>
References: <Pine.LNX.4.10.10208191744570.458-100000@master.linux-ide.org> <3D619776.7010104@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D619776.7010104@cox.net>
User-Agent: Mutt/1.4i
X-Accept-Language: cs, sk, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stanislav Brabec wrote:
>If module ide-floppy is loaded and no disc is present in the drive,
>/dev/ide/host0/bus1/target1/lun0/disc entry is not created. Later
>inserted media cannot be checked in any way, because no /dev entry
>exists.
>
Kevin P. Fleming wrote:
> diff -X dontdiff -urN linux/drivers/ide/ide-probe.c
> linux-probe/drivers/ide/ide-probe.c

Does anybody know, whether this problem was present on LS-120/240,
IOMEGA PocketZip and JAZ devices and is fixed now?

-- 
Stanislav Brabec
http://www.penguin.cz/~utx
