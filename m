Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161240AbWASHmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161240AbWASHmH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161253AbWASHmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:42:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32986 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161240AbWASHmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:42:06 -0500
Subject: Re: My vote against eepro* removal
From: Arjan van de Ven <arjan@infradead.org>
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323320@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F367323320@MAILIT.keba.co.at>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 08:42:03 +0100
Message-Id: <1137656523.2993.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 08:19 +0100, kus Kusche Klaus wrote:
> Last time I tested (around 2.6.12), eepro100 worked much better 
> in -rt kernels w.r.t. latencies than e100:

no offence but this is EXACTLY the reason why having 2 drivers for the
same hardware is bad. People (in general) will switch to the 2nd driver
if they hit some thing that is suboptimal, rather than reporting or even
fixing it. The result of that is that you end up with 2 drivers, each
serving a portion of the users but both suboptimal in non-overlapping
ways. Having one driver that's good enough for both groups is clearly
superior to that....


