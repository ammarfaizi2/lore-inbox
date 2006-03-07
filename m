Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWCGRrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWCGRrw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWCGRrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:47:52 -0500
Received: from hera.kernel.org ([140.211.167.34]:7616 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751143AbWCGRrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:47:51 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] Document Linux's memory barriers
Date: Tue, 7 Mar 2006 09:47:28 -0800
Organization: OSDL
Message-ID: <20060307094728.46875eb8@localhost.localdomain>
References: <31492.1141753245@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1141753647 5073 10.8.0.54 (7 Mar 2006 17:47:27 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 7 Mar 2006 17:47:27 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been needed for quite some time but needs some more
additions:

1) Access to i/o mapped memory does not need memory barriers.

2) Explain difference between mb() and barrier().

3) Explain wmb() versus mmiowb()

Give some more examples of correct usage in drivers.
