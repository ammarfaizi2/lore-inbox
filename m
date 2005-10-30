Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbVJ3QRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbVJ3QRq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 11:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVJ3QRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 11:17:46 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:39472 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751071AbVJ3QRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 11:17:45 -0500
To: Andi Kleen <ak@suse.de>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: Re: [PATCH] x86_64: Work around Re: 2.6.14-git1 (and -git2) build
 failure on AMD64
X-Message-Flag: Warning: May contain useful information
References: <16080000.1130681008@[10.10.2.4]> <200510301649.42064.ak@suse.de>
From: Roland Dreier <rolandd@cisco.com>
Date: Sun, 30 Oct 2005 08:17:39 -0800
In-Reply-To: <200510301649.42064.ak@suse.de> (Andi Kleen's message of "Sun,
 30 Oct 2005 16:49:41 +0100")
Message-ID: <52br17nfmk.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 30 Oct 2005 16:17:40.0709 (UTC) FILETIME=[7364D950:01C5DD6D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> Linus, can you please apply it?

No, please don't apply this.  The correct fix is to mark
toshiba_ohci1394_dmi_table[] as __devinitdata in that file, as in the
patch I posted here:

    http://lkml.org/lkml/2005/10/29/12

 - R.
