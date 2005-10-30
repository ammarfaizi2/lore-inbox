Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbVJ3OR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbVJ3OR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 09:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbVJ3OR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 09:17:56 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:28803 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750984AbVJ3OR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 09:17:56 -0500
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: 2.6.14-git1 (and -git2) build failure on AMD64
X-Message-Flag: Warning: May contain useful information
References: <16080000.1130681008@[10.10.2.4]>
From: Roland Dreier <rolandd@cisco.com>
Date: Sun, 30 Oct 2005 06:17:47 -0800
In-Reply-To: <16080000.1130681008@[10.10.2.4]> (Martin J. Bligh's message of
 "Sun, 30 Oct 2005 06:03:28 -0800")
Message-ID: <52k6fvnl6c.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 30 Oct 2005 14:17:48.0645 (UTC) FILETIME=[B496F950:01C5DD5C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed by:
    http://lkml.org/lkml/2005/10/29/12

You .config breaks because it has
    # CONFIG_HOTPLUG is not set

 - R.
