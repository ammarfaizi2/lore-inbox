Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUL1XY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUL1XY4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbUL1XY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:24:56 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:63723 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261169AbUL1XYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:24:46 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <200412272150.IBRnA4AvjendsF8x@topspin.com>
	<20041227225417.3ac7a0a6.davem@davemloft.net>
	<52pt0unr0i.fsf@topspin.com>
	<20041228141710.4daebcfb.davem@davemloft.net>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 28 Dec 2004 15:24:43 -0800
In-Reply-To: <20041228141710.4daebcfb.davem@davemloft.net> (David S.
 Miller's message of "Tue, 28 Dec 2004 14:17:10 -0800")
Message-ID: <52pt0uhupw.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][v5][0/24] Latest IB patch queue
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 28 Dec 2004 23:24:44.0104 (UTC) FILETIME=[69B92480:01C4ED34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> I believe that you didn't test the sparc64 build of the
    David> infiniband stuff because arch/sparc64/Kconfig needs to
    David> explicitly include the infiniband Kconfig since it does not
    David> use drivers/Kconfig.  You didn't send me any such changes.

Actually I did test the build (and Tom Duffy at Sun has actually run
the drivers on his system), but I forgot to include the required Kconfig
change -- I just have it in my local test tree.

    David> There are a few platforms which also are in this situation.
    David> I added the sparc64 one to my tree while integrating your
    David> changes, but the others need to be attended to if you wish
    David> infiniband to be configurable on them.

I think sparc64 is the only such platform where InfiniBand is likely
to be of much interest.  However I'll check out all of arch/ and send
patches to hook up drivers/infiniband/ to the relevant maintainers
once IB makes it upstream.

Thanks,
  Roland
