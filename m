Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbUKWPIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbUKWPIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 10:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbUKWPGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 10:06:31 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:62071 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261290AbUKWPGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 10:06:15 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041122714.nKCPmH9LMhT0X7WE@topspin.com>
	<20041122714.9zlcKGKvXlpga8EP@topspin.com>
	<20041122225033.GD15634@kroah.com> <52ekil9v1m.fsf@topspin.com>
	<20041123063045.GA22493@kroah.com> <52llct83o1.fsf@topspin.com>
	<20041123074337.GB23194@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 23 Nov 2004 07:06:07 -0800
In-Reply-To: <20041123074337.GB23194@kroah.com> (Greg KH's message of "Mon,
 22 Nov 2004 23:43:37 -0800")
Message-ID: <523bz08v1c.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v1][9/12] Add InfiniBand userspace MAD support
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 15:06:13.0371 (UTC) FILETIME=[F9143CB0:01C4D16D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Yes, it probably should be.  Hm, no, we don't allow you to
    Greg> put class specific files if you use the class_simple API,
    Greg> sorry I misread your question.  You can just handle the
    Greg> class yourself and use the CLASS_ATTR() macro to define your
    Greg> api version function.

Ugh, then we end up duplicating the class_simple code.  Would you
accept a patch that adds class_simple_create_file()/class_simple_remove_file()?

Thanks,
  Roland
