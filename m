Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbUCCQIJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 11:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbUCCQIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 11:08:09 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:5133 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262515AbUCCQIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 11:08:06 -0500
Date: Wed, 3 Mar 2004 16:08:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <20040303160802.A30084@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave McCracken <dmccr@us.ibm.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <20040303070933.GB4922@dualathlon.random> <20040303025820.2cf6078a.akpm@osdl.org> <7440000.1078328791@[10.10.2.4]> <7710000.1078329523@[10.1.1.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <7710000.1078329523@[10.1.1.4]>; from dmccr@us.ibm.com on Wed, Mar 03, 2004 at 09:58:44AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 09:58:44AM -0600, Dave McCracken wrote:
> It'd mean the page struct would have to have a count of the number of
> mlock()ed regions it belongs to, and we'd have to update all the pages each
> time we call it.

That would add another atomic_t to struct pages..

But if we did it it would help some xfs fixes I'm doing currently a whole lot

