Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbULTQpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbULTQpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 11:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbULTQpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 11:45:55 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:60688 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261566AbULTQpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 11:45:51 -0500
To: YOSHIFUJI Hideaki / =?iso-2022-jp?b?GyRCNUhGIzFRGyhC?=
	 =?iso-2022-jp?b?GyRCTEAbKEI=?= <yoshfuji@linux-ipv6.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       netdev@oss.sgi.com
X-Message-Flag: Warning: May contain useful information
References: <200412192215.69tnzAhGIT1vQGLF@topspin.com>
	<200412192215.fZX1ZQqQD4QGkKcF@topspin.com>
	<20041220.155836.75677852.yoshfuji@linux-ipv6.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 20 Dec 2004 08:45:49 -0800
In-Reply-To: <20041220.155836.75677852.yoshfuji@linux-ipv6.org> (YOSHIFUJI
 Hideaki's message of "Mon, 20 Dec 2004 15:58:36 +0900 (JST)")
Message-ID: <52is6wkjeq.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][v4][19/24] Add IPoIB (IP-over-InfiniBand) driver
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 20 Dec 2004 16:45:50.0074 (UTC) FILETIME=[5C9FFDA0:01C4E6B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    YOSHIFUJI> above entries does not seem to appropriate for enum
    YOSHIFUJI> (than #define).

As Arnd mentioned, I thought enum values were preferred to using the
preprocessor.  What's the advantage of converting to macros (which
have no type, are invisible to the compiler, etc)?

Thanks,
  Roland
