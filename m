Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWAWIZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWAWIZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 03:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWAWIZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 03:25:27 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:40125 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751426AbWAWIZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 03:25:26 -0500
Message-ID: <43D49417.9060204@aitel.hist.no>
Date: Mon, 23 Jan 2006 09:30:15 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Stoffel <john@stoffel.org>
CC: Takashi Sato <sho@tnes.nec.co.jp>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext3: Extends blocksize up to pagesize
References: <000001c61c30$00814e80$4168010a@bsd.tnes.nec.co.jp> <17358.25398.943860.755559@smtp.charter.net>
In-Reply-To: <17358.25398.943860.755559@smtp.charter.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel wrote:

>Takashi> As a disk tends to get large, a disk storage has had a
>Takashi> capacity to supply multi-TB.  But now, ext3 can't support
>Takashi> more than 8TB filesystem when blocksize is 4KB.  That's why I
>Takashi> think ext3 needs to be more than 8TB.
>
>Man, I don't want to even think about doing an FSCK on an 8TB
>filesystem running ext[23] at all.  
>
>In that size range, you really need a filesystem which doesn't need an
>FSCK at all.  Not sure what the real answer is though...
>  
>
An fs that allows consistency checking while in use, perhaps?
Then it doesn't matter if it takes days, for you can use the fs
in the meantime.

Helge Hafting
