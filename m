Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTIWSKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTIWSKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:10:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25051 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263276AbTIWSKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:10:11 -0400
Date: Tue, 23 Sep 2003 10:57:12 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
       bcrl@kvack.org, ak@suse.de, iod00d@hp.com, peterc@gelato.unsw.edu.au,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923105712.552dbb1e.davem@redhat.com>
In-Reply-To: <BFF315B8E1D7F845B8FC1C28778693D70AFEC6@usslc-exch1.na.uis.unisys.com>
References: <BFF315B8E1D7F845B8FC1C28778693D70AFEC6@usslc-exch1.na.uis.unisys.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 12:58:59 -0500
"Van Maren, Kevin" <kevin.vanmaren@unisys.com> wrote:

> Rate-limited unaligned loads in user space make a lot more sense, since
> they _may_ point out issues in the code.

That's what generates the bulk of the noise in people's ia64
dmesg output.
