Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268177AbUHFQX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbUHFQX6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268168AbUHFQVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:21:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29117 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268172AbUHFQVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:21:14 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Altix I/O code reorganization
Date: Fri, 6 Aug 2004 09:19:20 -0700
User-Agent: KMail/1.6.2
Cc: Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org>
In-Reply-To: <20040806141836.A9854@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408060919.20993.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 6, 2004 6:18 am, Christoph Hellwig wrote:
> Yikes, this is truely horrible.  First your patch ordering doesn't make
> any sense, with just the first patch applied the system won't work at all.
> Please submit a series of _small_ patches going from A to B keeping the
> code working everywhere inbetween.

Much of this stuff is clearly interdependent (and dependent on PROM changes), 
so I don't think that would make sense.

Jesse
