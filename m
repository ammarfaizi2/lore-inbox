Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUENOkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUENOkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 10:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUENOkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 10:40:25 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:785 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261358AbUENOkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 10:40:10 -0400
Date: Fri, 14 May 2004 15:40:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/7] perfctr-2.7.2 for 2.6.6-mm2: core
Message-ID: <20040514154005.A24977@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200405141409.i4EE9Uhd018397@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200405141409.i4EE9Uhd018397@alkaid.it.uu.se>; from mikpe@csd.uu.se on Fri, May 14, 2004 at 04:09:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haven't looked over much of the code yet, but the people who support
32bit userspace on 64bit architectures will probably kill you for
the multiplexer syscall.  And even without that it's a really horrible
interface.  Any chance to do a proper fs-based interface ala oprofile?
