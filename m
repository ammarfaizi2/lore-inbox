Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267823AbUJPRwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267823AbUJPRwB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 13:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268315AbUJPRwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 13:52:01 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:54014 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267823AbUJPRwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 13:52:00 -0400
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <416FCD3E.8010605@drzeus.cx> <41713B79.3080406@drzeus.cx>
	<52brf2bqfz.fsf@topspin.com> <41714E02.3020501@drzeus.cx>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 16 Oct 2004 10:51:53 -0700
In-Reply-To: <41714E02.3020501@drzeus.cx> (Pierre Ossman's message of "Sat,
 16 Oct 2004 18:36:18 +0200")
Message-ID: <527jpqblfq.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: Tasklet usage?
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 16 Oct 2004 17:51:54.0969 (UTC) FILETIME=[D3093490:01C4B3A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Pierre> Just out of curiosity, how do you declare a 32-bit int
    Pierre> then? I thought longlong would be the 64-bit int under gcc
    Pierre> and long stay as it is.

int is still 32 bits on all Linux platforms (as far as I know).  To
make it explicit you can use s32.

 - Roland

