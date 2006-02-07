Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWBGDu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWBGDu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWBGDu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:50:26 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:50725 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S964966AbWBGDu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:50:26 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Roland Dreier <rolandd@cisco.com>, Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Willem Riede <osst@riede.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [git patch review 2/2] IB: Don't doublefree pages from
 scatterlist
X-Message-Flag: Warning: May contain useful information
References: <1139070837112-3fe13a3288c20f5c@cisco.com>
	<Pine.LNX.4.61.0602062221200.3844@goblin.wat.veritas.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Feb 2006 17:44:14 -0800
In-Reply-To: <Pine.LNX.4.61.0602062221200.3844@goblin.wat.veritas.com> (Hugh
 Dickins's message of "Mon, 6 Feb 2006 22:29:59 +0000 (GMT)")
Message-ID: <ada7j88hrip.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 07 Feb 2006 01:44:14.0572 (UTC) FILETIME=[0035F2C0:01C62B88]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hugh> It's now looking like this change won't be needed after all:
    Hugh> Andi has just posted a patch in the "ipr" thread which
    Hugh> should stop x86_64 from interfering with the scatterlist
    Hugh> *page,offset,length fields, so what IB and others were doing
    Hugh> should then work safely (current thinking is that x86_64 is
    Hugh> the only architecture which coalesced in that way).

OK, I'll drop this from my tree.

 - R.
