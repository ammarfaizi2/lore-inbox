Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317851AbSGaIWG>; Wed, 31 Jul 2002 04:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317854AbSGaIWG>; Wed, 31 Jul 2002 04:22:06 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:261 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317851AbSGaIWG>; Wed, 31 Jul 2002 04:22:06 -0400
Date: Wed, 31 Jul 2002 09:25:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>, Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29
Message-ID: <20020731092527.A8443@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Rik van Riel <riel@conectiva.com.br>,
	Benjamin LaHaise <bcrl@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-aio@kvack.org
References: <20020730214116.GN1181@dualathlon.random> <Pine.LNX.4.44L.0207302219400.23404-100000@imladris.surriel.com> <20020731013238.GJ1181@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020731013238.GJ1181@dualathlon.random>; from andrea@suse.de on Wed, Jul 31, 2002 at 03:32:38AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 03:32:38AM +0200, Andrea Arcangeli wrote:
> disagree, merging synchronous requests would make much more sense than
> merging asynchronous requests in the same syscall, it would make them
> asynchronous with respect than each other without losing their global
> synchronous behaviour w.r.t. userspace.

readv/writev..

