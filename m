Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWHVUio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWHVUio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 16:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWHVUio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 16:38:44 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14795
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932122AbWHVUin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 16:38:43 -0400
Date: Tue, 22 Aug 2006 13:39:01 -0700 (PDT)
Message-Id: <20060822.133901.110902970.davem@davemloft.net>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       dj@david-web.co.uk
Subject: Re: sym53c8xx PCI card broken in 2.6.18
From: David Miller <davem@davemloft.net>
In-Reply-To: <200608221546.11532.dj@david-web.co.uk>
References: <200608221546.11532.dj@david-web.co.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sounds like the interrupts are being misconfigured for the
PCI card.  Please post 2 pieces of information:

1) Boot logs with "ofdebug=2" given on the kernel command line
2) Output of "/usr/sbin/prtconf -pv"

Thanks.
