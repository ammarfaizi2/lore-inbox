Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbULNAO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbULNAO5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 19:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbULNAO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 19:14:57 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:28785 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261353AbULNAO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 19:14:56 -0500
To: "Hal Rosenstock" <halr@voltaire.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       <openib-general@openib.org>
X-Message-Flag: Warning: May contain useful information
References: <5CE025EE7D88BA4599A2C8FEFCF226F5175B0C@taurus.voltaire.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 13 Dec 2004 16:14:54 -0800
In-Reply-To: <5CE025EE7D88BA4599A2C8FEFCF226F5175B0C@taurus.voltaire.com> (Hal
 Rosenstock's message of "Mon, 13 Dec 2004 22:19:09 +0200")
Message-ID: <52sm694txd.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [openib-general] [PATCH][v3][17/21] Add IPoIB
 (IP-over-InfiniBand)driver
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 14 Dec 2004 00:14:55.0311 (UTC) FILETIME=[F0589DF0:01C4E171]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hal> The latest I-D is now
    Hal> http://www.ietf.org/internet-drafts/draft-ietf-ipoib-ip-over-infiniband-08.txt

Thanks, I'll correct this.

    Hal> Also, isn't DHCP over IB
    Hal> (http://www.ietf.org/internet-drafts/draft-ietf-ipoib-dhcp-over-infiniband-07.txt)
    Hal> also supported ? If so, is that part of this or some other
    Hal> patch being submitted ?

DHCP should work but I don't think it's a kernel issue (I don't think
kernel DHCP for NFS root over IPoIB will work unfortunately).

 - R.
