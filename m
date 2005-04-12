Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVDLSfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVDLSfM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVDLSdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:33:15 -0400
Received: from webmail.topspin.com ([12.162.17.3]:36441 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262525AbVDLRy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 13:54:28 -0400
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch 164/198] IB/mthca: fill in more device query fields
X-Message-Flag: Warning: May contain useful information
References: <200504121033.j3CAXDWW005823@shell0.pdx.osdl.net>
	<200504122111.34696.adobriyan@mail.ru>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 12 Apr 2005 10:27:59 -0700
In-Reply-To: <200504122111.34696.adobriyan@mail.ru> (Alexey Dobriyan's
 message of "Tue, 12 Apr 2005 21:11:34 +0000")
Message-ID: <52oecjucps.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Apr 2005 17:27:59.0690 (UTC) FILETIME=[F91282A0:01C53F84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    >> + memset(props, 0, sizeof props);

    Alexey> sizeof *props ?

Indeed -- excellent catch considering the volume of patches that went
by today.  I've committed this fix to our svn tree so it won't get
lost, and I'll send it upstream once the patch backlog cleared a bit.

Thanks,
  Roland

