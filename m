Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVADTh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVADTh6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVADTgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:36:07 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:33419 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261832AbVADTWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:22:24 -0500
To: Jiri Gaisler <jiri@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
X-Message-Flag: Warning: May contain useful information
References: <41DAE8CC.3010904@gaisler.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 04 Jan 2005 11:22:14 -0800
In-Reply-To: <41DAE8CC.3010904@gaisler.com> (Jiri Gaisler's message of "Tue,
 04 Jan 2005 20:04:44 +0100")
Message-ID: <528y7957a1.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [7/7] LEON SPARC V8 processor support for linux-2.6.10
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 04 Jan 2005 19:22:20.0279 (UTC) FILETIME=[B5D1D070:01C4F292]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there no way to do this:

    > +ifneq ($(CONFIG_LEON_3),y)
    > +obj-$(CONFIG_SERIAL_LEON) += leon.o
    > +endif

by using dependencies in Kconfig rather than adding conditionals to
the Makefile?  Does it work to make SERIAL_LEON depend on LEON && !LEON_3?

 - R.

