Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUJFBAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUJFBAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUJFBAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:00:33 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:63829 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266560AbUJFBAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:00:23 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <4136E4660006E2F7@mail-7.tiscali.it> <41634236.1020602@pobox.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 05 Oct 2004 18:00:16 -0700
In-Reply-To: <41634236.1020602@pobox.com> (Jeff Garzik's message of "Tue, 05
 Oct 2004 20:54:14 -0400")
Message-ID: <52is9or78f.fsf_-_@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 06 Oct 2004 01:00:17.0697 (UTC) FILETIME=[D8830110:01C4AB3F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> I strongly recommend disabling kernel preemption.  It is a
    Jeff> hack that hides bugs.

Why do you say that?  Preempt seems to be the cleanest way to low
latency, and if anything it exposes locking bugs and races rather than
hiding anything.

Thanks,
  Roland
