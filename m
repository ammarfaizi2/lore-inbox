Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTFXWQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTFXWQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:16:56 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:6729 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263062AbTFXWQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:16:55 -0400
Date: Tue, 24 Jun 2003 15:31:54 -0700
From: Andrew Morton <akpm@digeo.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: clem@clem.clem-digital.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 -- Uninitialised timer! (i386)
Message-Id: <20030624153154.7243549d.akpm@digeo.com>
In-Reply-To: <16120.50188.29.739261@gargle.gargle.HOWL>
References: <20030624124800.72bfb98d.akpm@digeo.com>
	<200306242033.QAA27440@clem.clem-digital.net>
	<16120.50188.29.739261@gargle.gargle.HOWL>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jun 2003 22:31:04.0900 (UTC) FILETIME=[4C7DD840:01C33AA0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> Apply the patch below (which I posted to LKML yesterday btw).
>  2.5.73 incorrectly removed the workaround needed to prevent
>  gcc-2.95.x from miscompiling spinlocks on UP (they become
>  empty structs, and gcc-2.95.x has problems with those).

Are you sure?  I saw no problems with 2.95.3.  Maybe it's
a 2.95.4 problem?
