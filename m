Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbUKOV4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbUKOV4s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 16:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUKOV4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 16:56:48 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:33321 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261395AbUKOVza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 16:55:30 -0500
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <419914F9.7050509@techsource.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 15 Nov 2004 13:55:24 -0800
In-Reply-To: <419914F9.7050509@techsource.com> (Timothy Miller's message of
 "Mon, 15 Nov 2004 15:43:37 -0500")
Message-ID: <52is86lqur.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: Intel Corp. 82801BA/BAM not supported by ALSA?
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 15 Nov 2004 21:55:29.0703 (UTC) FILETIME=[D27D2370:01C4CB5D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Timothy> When I do 'lspci | grep -i audio', I get this:
    Timothy> 0000:00:1f.5 Multimedia audio controller: Intel
    Timothy> Corp. 82801BA/BAM AC'97 Audio (rev 04)

I would guess it should be supported by snd_intel8x0.  What are the
exact device ID's (shown by lspci -n)?

 - R.
