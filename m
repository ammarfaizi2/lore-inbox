Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWI2KCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWI2KCO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 06:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWI2KCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 06:02:14 -0400
Received: from ironport-c10.fh-zwickau.de ([141.32.72.200]:58895 "EHLO
	ironport-c10.fh-zwickau.de") by vger.kernel.org with ESMTP
	id S1751023AbWI2KCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 06:02:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAABCKHEWLfAEBDQ
X-IronPort-AV: i="4.09,234,1157320800"; 
   d="scan'208"; a="3628484:sNHT30957080"
Date: Fri, 29 Sep 2006 12:02:11 +0200
From: Joerg Roedel <joro-lkml@zlug.org>
To: Tchesmeli Serge <serge@lea-linux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] ? Strange behaviour since kernel 2.6.17 with a https website
Message-ID: <20060929100211.GB19115@zlug.org>
References: <451CEBA8.8050604@lea-linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451CEBA8.8050604@lea-linux.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 11:47:20AM +0200, Tchesmeli Serge wrote:

> Me and a friend have discover a stange behaviour since kernel 2.6.17.

Please try to switch off TCP window scaling using the command below
(as root) and retry.

echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
