Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTKZNYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 08:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTKZNX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 08:23:59 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:18694 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262784AbTKZNXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 08:23:15 -0500
Date: Wed, 26 Nov 2003 13:23:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test10-mm1
Message-ID: <20031126132311.B5477@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031125211518.6f656d73.akpm@osdl.org> <20031126085123.A1952@infradead.org> <20031126044251.3b8309c1.akpm@osdl.org> <20031126130936.A5275@infradead.org> <20031126132144.GN8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031126132144.GN8039@holomorphy.com>; from wli@holomorphy.com on Wed, Nov 26, 2003 at 05:21:44AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 05:21:44AM -0800, William Lee Irwin III wrote:
> I'm not one to toe the party line, but this really does seem innocuous
> and of more general use than GPFS. I'd say walking pagetables directly
> in fs and/or device drivers is more invasive wrt. VM internals than
> calling a well-established procedure, but that's just me.

GPFS is doing all that, too of course.  Take a look at their glue code
at oss.software.ibm.com (and take a barf-bag with you while you're at
it..)

