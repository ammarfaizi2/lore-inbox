Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbVIVUqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVIVUqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 16:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVIVUqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 16:46:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751166AbVIVUqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 16:46:34 -0400
Date: Thu, 22 Sep 2005 13:46:10 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zan Lynx <zlynx@acm.org>
Cc: Valdis.Kletnieks@vt.edu, breno@kalangolinux.org,
       linux-kernel@vger.kernel.org
Subject: Re: security patch
Message-ID: <20050922204610.GK7991@shell0.pdx.osdl.net>
References: <20050922194433.13200.qmail@webmail2.locasite.com.br> <200509222003.j8MK3i8E010365@turing-police.cc.vt.edu> <1127420688.10462.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127420688.10462.9.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zan Lynx (zlynx@acm.org) wrote:
> An interesting thing that I don't think has been done before is to
> create a map linking stack call chains to syscalls.  If the call stack
> doesn't match then it isn't a valid call.

There's been a fair amount of research in anomaly detection.  It's not
as effective as you might hope.  Can be slow, and since it's typically
based on statistics, needs to be properly trained (can be difficult) and
may be ineffective if you stay below anomaly threshold.

thanks,
-chris
