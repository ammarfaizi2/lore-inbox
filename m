Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263242AbVBDRj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263242AbVBDRj3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbVBDR0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:26:53 -0500
Received: from web51602.mail.yahoo.com ([206.190.38.207]:945 "HELO
	web51602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264719AbVBDR0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:26:23 -0500
Message-ID: <20050204172618.51558.qmail@web51602.mail.yahoo.com>
Date: Fri, 4 Feb 2005 18:26:17 +0100 (CET)
From: =?iso-8859-1?q?Terje=20F=E5berg?= <terje_fb@yahoo.no>
Subject: Re: 2.6.10: kswapd spins like crazy
To: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Cc: terje_fb@yahoo.no, linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20050204102637.94143.qmail@web51608.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Fåberg <terje_fb@yahoo.no> skrev: 

> I'll continue to do the same things I did yesterday
> before kswapd started to spin. 

Looks very good so far. I am unable to reproduce the
bad kswapd behaviour with your patch, Nick.

To double-check I booted into the old kernel an hour
ago and I _could_ reproduce the bad behaviour within a
few minutes. 

Looks like your patch fixes it for my workload.

Thanks a lot,
Terje

