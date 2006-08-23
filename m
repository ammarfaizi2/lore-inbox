Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWHWJcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWHWJcs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWHWJcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:32:47 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:13478 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751479AbWHWJcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:32:47 -0400
Date: Wed, 23 Aug 2006 11:32:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Robert Szentmihalyi <robert.szentmihalyi@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Group limit for NFS exported file systems
In-Reply-To: <20060823091652.235230@gmx.net>
Message-ID: <Pine.LNX.4.61.0608231129550.5799@yvahk01.tjqt.qr>
References: <20060823091652.235230@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>
>is there a group limit for NFS exported file systems in recent kernels?
>One if my users cannot access directories that belong to a group he actually _is_ a member of. That, however, is true only when accessing them over NFS. On the local file system, everything is fine. UIDs and GIDs are the same on client and server, so that cannot be the problem. Client and server run Gentoo Linux with kernel 2.6.16 on the server and 2.6.17 on the client.
>Any ideas?

Is his fsuid/fsgid suddenly different?


Jan Engelhardt
-- 
