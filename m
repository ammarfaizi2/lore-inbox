Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbSLWVxT>; Mon, 23 Dec 2002 16:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbSLWVxT>; Mon, 23 Dec 2002 16:53:19 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:13273 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S266983AbSLWVxS>;
	Mon, 23 Dec 2002 16:53:18 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: Problem with read blocking for a long time on /dev/scd1
References: <87adj0b3hj.fsf@stark.dyndns.tv>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 23 Dec 2002 19:02:37 +0100
In-Reply-To: <87adj0b3hj.fsf@stark.dyndns.tv>
Message-ID: <m3fzsoipfm.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Stark <gsstark@mit.edu> writes:

> I'm having a problem with ogle that seems to be being caused by the scsi or
> ide-scsi driver. The video playback freezes for a second or randomly,
> sometimes every few seconds, sometimes not for several minutes. Every such
> glitch is correlated perfectly with a read syscall reading on /dev/scd1
> blocking for an inordinate amount of time.

And scd1 is a ide-scsi CDROM? The CDROM might have problem reading the
disc, and it blocks the entire bus. IDEs AFAIK don't disconnect.
-- 
Krzysztof Halasa
Network Administrator
