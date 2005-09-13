Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVIMUYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVIMUYw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVIMUYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:24:52 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:982
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932314AbVIMUYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:24:51 -0400
Date: Tue, 13 Sep 2005 13:24:42 -0700 (PDT)
Message-Id: <20050913.132442.53540386.davem@davemloft.net>
To: kiran@scalex86.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       bharata@in.ibm.com, shai@scalex86.org, rusty@rustcorp.com.au,
       netdev@vger.kernel.org
Subject: Re: [patch 9/11] net: dst_entry.refcount, use, lastuse to use
 alloc_percpu
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050913161708.GK3570@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain>
	<20050913161708.GK3570@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is no way in the world this enormous amount of NUMA
complexity is being added to the destination cache layer.

Sorry.
