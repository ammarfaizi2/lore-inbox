Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUJFAam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUJFAam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 20:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUJFAam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 20:30:42 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:46162 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266505AbUJFAaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 20:30:19 -0400
To: root <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.53.0410051852250.351@chaos.analogic.com>
	<52vfdoraly.fsf@topspin.com>
	<Pine.LNX.4.61.0410051958100.4660@chaos.analogic.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 05 Oct 2004 17:30:17 -0700
In-Reply-To: <Pine.LNX.4.61.0410051958100.4660@chaos.analogic.com> (root@chaos.analogic.com's
 message of "Tue, 5 Oct 2004 19:59:28 -0400 (EDT)")
Message-ID: <52mzz0r8me.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: Linux-2.6.5-1.358 SMP
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 06 Oct 2004 00:30:18.0291 (UTC) FILETIME=[A7FB7030:01C4AB3B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    root> Ahah!  I just put that in the headers that define the functions??

I'm not enough of a gcc expert to know for sure, but I think you need
it in both the functions and the actual source.  You can grep the
kernel source for "asmlinkage" to find dozens of examples of its use.

 - Roland
