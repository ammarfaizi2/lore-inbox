Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265719AbTIETFQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 15:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265728AbTIETFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 15:05:16 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:63464 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265719AbTIETFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 15:05:12 -0400
Date: Fri, 05 Sep 2003 11:54:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v12
Message-ID: <195560000.1062788044@flay>
In-Reply-To: <3F58CE6D.2040000@cyberone.com.au>
References: <3F58CE6D.2040000@cyberone.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Backboost is gone so X really should be at -10 or even higher.

Wasn't that causing half the problems originally? Boosting X seemed
to starve xmms et al. Or do the interactivity changes fix xmms
somehow, but not X itself? Explicitly fiddling with task's priorities
seems flawed to me.

M.

