Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261749AbTCZPec>; Wed, 26 Mar 2003 10:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261750AbTCZPec>; Wed, 26 Mar 2003 10:34:32 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:33796 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261749AbTCZPeV>; Wed, 26 Mar 2003 10:34:21 -0500
Date: Wed, 26 Mar 2003 15:45:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] s390 update (1/9): s390 arch fixes.
Message-ID: <20030326154533.B17795@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <200303261605.33937.schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303261605.33937.schwidefsky@de.ibm.com>; from schwidefsky@de.ibm.com on Wed, Mar 26, 2003 at 04:05:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks you do exactly the same changes to both s390 and s390x.  A closer
look at the arch directories shows that about 95% of the code is exactly
the same.  Can you remove the s390x dir and abstract out the few differences
into a config option?

