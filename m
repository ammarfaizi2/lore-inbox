Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265179AbTFYXGT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbTFYXGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:06:19 -0400
Received: from relay02.roc.ny.frontiernet.net ([66.133.131.35]:45274 "EHLO
	relay02.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S265179AbTFYXE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:04:56 -0400
Date: Wed, 25 Jun 2003 19:19:06 -0400
From: Scott McDermott <vaxerdec@frontiernet.net>
To: Jonathan Hudson <jonathan@daria.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: weird postfix mailspool corruption with 2.4.21-ac2+ (was Re: Linux 2.4.21-ac3)
Message-ID: <20030625191906.C9146@newbox.localdomain>
References: <fa.hh6ttrp.1d52bhj@ifi.uio.no> <fa.h3c32fv.r5m12l@ifi.uio.no> <f65.3efa238d.6e30e@trespassersw.daria.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <f65.3efa238d.6e30e@trespassersw.daria.co.uk>; from jonathan@daria.co.uk on Wed, Jun 25, 2003 at 11:34:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Hudson on Wed 25/06 23:34 +0100:
> No AIC or any kind here. Bring on the next suspect.

does changing the unix_dgram_ops `poll' op from `dgram_poll'
to `datagram_poll' in net/unix/af_unix.c change anything for
you? I can't test this myself until later this week.  Also I
don't know what other bug the unix_peer_get() addition is
supposed to fix, so...
