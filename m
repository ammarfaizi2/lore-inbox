Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWFWFy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWFWFy2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 01:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWFWFy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 01:54:27 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:21379 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S932323AbWFWFy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 01:54:26 -0400
X-IronPort-AV: i="4.06,167,1149490800"; 
   d="scan'208"; a="1831134735:sNHT33218120"
To: Andrew Morton <akpm@osdl.org>
Cc: Ananda Raju <Ananda.Raju@neterion.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       dgc@sgi.com, balbir@in.ibm.com, viro@zeniv.linux.org.uk, neilb@suse.de,
       jblunck@suse.de, tglx@linutronix.de, leonid.grossman@neterion.com,
       ravinandan.arakali@neterion.com, alicia.pena@neterion.com
Subject: Re: [patch 2.6.17] s2io driver irq fix
X-Message-Flag: Warning: May contain useful information
References: <Pine.GSO.4.10.10606211537540.23949-100000@guinness>
	<20060621211534.b740d0f8.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 22 Jun 2006 22:54:23 -0700
In-Reply-To: <20060621211534.b740d0f8.akpm@osdl.org> (Andrew Morton's message of "Wed, 21 Jun 2006 21:15:34 -0700")
Message-ID: <adalkrol8mo.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Jun 2006 05:54:24.0329 (UTC) FILETIME=[7AE71B90:01C69689]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andrew> Is it usual to prohibit IRQ sharing with msix?

With current code at least, MSI/MSI-X interrupts can never be shared.

 - R.
