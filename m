Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbUKWGu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbUKWGu3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbUKWGsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:48:31 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:575 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262235AbUKWGrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:47:46 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041122713.SDrx8l5Z4XR5FsjB@topspin.com>
	<20041122713.g6bh6aqdXIN4RJYR@topspin.com>
	<20041122222507.GB15634@kroah.com> <527jodbgqo.fsf@topspin.com>
	<20041123064120.GB22493@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 22 Nov 2004 22:47:29 -0800
In-Reply-To: <20041123064120.GB22493@kroah.com> (Greg KH's message of "Mon,
 22 Nov 2004 22:41:20 -0800")
Message-ID: <52hdnh83jy.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA (Subnet Administration)
 query support
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 06:47:34.0836 (UTC) FILETIME=[503E1740:01C4D128]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Yeah, but a name in each file is much nicer.

Very little of the kernel seems to follow this rule right now.

    Greg> One comment, the file drivers/infiniband/core/cache.c has a
    Greg> license that is illegal due to the contents of the file.
    Greg> Please change the license of the file to GPL only.

?? Can you explain this?  What makes that file special?

    Greg> Oh, and how about kernel-doc comments for all functions that
    Greg> are EXPORT_SYMBOL() marked?  And for your core big
    Greg> structures?

I guess we'll start working on it...

 - Roland
