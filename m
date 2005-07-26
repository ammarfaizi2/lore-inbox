Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVGZSG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVGZSG5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVGZSGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:06:51 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22028 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261988AbVGZSFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:05:15 -0400
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, akpm@osdl.org
Subject: Re: Memory pressure handling with iSCSI
X-Message-Flag: Warning: May contain useful information
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 26 Jul 2005 11:04:58 -0700
In-Reply-To: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com> (Badari
 Pulavarty's message of "Tue, 26 Jul 2005 10:35:30 -0700")
Message-ID: <52wtndfnp1.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Jul 2005 18:05:09.0906 (UTC) FILETIME=[8FC23720:01C5920C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Badari> I created 50 10-GB ext3 filesystems on iSCSI luns. Test is
    Badari> simple 50 dds (one per filesystem). System seems to
    Badari> throttle memory properly and making progress. (Machine
    Badari> doesn't respond very well for anything else, but my vmstat
    Badari> keeps running - 100% sys time).

Thanks, this is a good test.  It would be interesting to know if the
system does eventually deadlock with less system memory or with even
more filesystems.

 - R.
