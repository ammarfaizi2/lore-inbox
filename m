Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262913AbUKYCMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUKYCMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 21:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbUKYCMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 21:12:07 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:55671 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262913AbUKYCME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 21:12:04 -0500
To: linux-kernel@vger.kernel.org
Cc: openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041123814.p0AnYzTlx42JeVes@topspin.com>
	<20041123814.rXLIXw020elfd6Da@topspin.com>
	<20041123195345.GC8367@mars.ravnborg.org>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 24 Nov 2004 11:39:27 -0800
In-Reply-To: <20041123195345.GC8367@mars.ravnborg.org> (Sam Ravnborg's
 message of "Tue, 23 Nov 2004 20:53:45 +0100")
Message-ID: <52brdnyr2o.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v2][1/21] Add core InfiniBand support (public
 headers)
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 24 Nov 2004 19:39:32.0774 (UTC) FILETIME=[524C4C60:01C4D25D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Sam> After giving it a second thought my vote goes for:
    Sam> include/linux/infiniband

Could you share the reasoning that led to that preference?

Unfortunately we don't seem to be converging on one choice of location.

On one side there is the fact that the .h files are not used outside
of drivers/infiniband -- hence they should stay under drivers/infiniband.

On the other side is the fact that moving the includes under include/
gets rid of some CFLAGS lines in the Makefile.

I don't see a conclusive reason to choose any particular place.
Perhaps Linus or Andrew can simply hand down an authoritative answer?

Thanks,
  Roland
