Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVBQVYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVBQVYE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 16:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVBQVYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 16:24:03 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:31713 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261162AbVBQVX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 16:23:57 -0500
To: linux-os@analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Needlessly global functions static...."
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.61.0502171607500.18275@chaos.analogic.com>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 17 Feb 2005 13:23:52 -0800
In-Reply-To: <Pine.LNX.4.61.0502171607500.18275@chaos.analogic.com> (linux-os@analogic.com's
 message of "Thu, 17 Feb 2005 16:12:32 -0500 (EST)")
Message-ID: <52wtt6vq1j.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Feb 2005 21:23:52.0851 (UTC) FILETIME=[FAB4FE30:01C51536]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    linux-os> Hello, Tell me. When all those kernel functions are made
    linux-os> static how does one use a kernel debugger? How does the
    linux-os> OOPS get decoded if nothing is in /proc/kallsyms or
    linux-os> System.map???

Dude, static symbols are still in System.map and /proc/kallsyms.
