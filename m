Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbULJTii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbULJTii (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 14:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbULJTih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 14:38:37 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:49602 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261807AbULJTid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 14:38:33 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
X-Message-Flag: Warning: May contain useful information
References: <20041210005055.GA17822@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 10 Dec 2004 11:38:31 -0800
In-Reply-To: <20041210005055.GA17822@kroah.com> (Greg KH's message of "Thu,
 9 Dec 2004 16:50:56 -0800")
Message-ID: <52brd29c5k.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [RFC PATCH] debugfs - yet another in-kernel file system
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 10 Dec 2004 19:38:32.0139 (UTC) FILETIME=[D4C421B0:01C4DEEF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> p.s. I think the recently posted infiband driver can take
    Greg> advantage of this fs instead of having to create it's own
    Greg> debug filesystem.

Yes, if this gets merged, I'll convert the "ipoib_debugfs" in the
OpenIB drivers to just use debugfs stuff.

Thanks,
  Roland
