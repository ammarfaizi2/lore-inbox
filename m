Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312085AbSCTTrG>; Wed, 20 Mar 2002 14:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312083AbSCTTq5>; Wed, 20 Mar 2002 14:46:57 -0500
Received: from imladris.infradead.org ([194.205.184.45]:2317 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S312081AbSCTTqx>;
	Wed, 20 Mar 2002 14:46:53 -0500
Date: Wed, 20 Mar 2002 19:45:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Hugh Dickins <hugh@veritas.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
Message-ID: <20020320194549.A32457@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Andrea Arcangeli <andrea@suse.de>, Hugh Dickins <hugh@veritas.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Dave McCracken <dmccr@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <127930000.1016651345@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Any chance to make your mailer wrap lines after 76 lines?
 That would make reading a lot easier..]

On Wed, Mar 20, 2002 at 11:09:05AM -0800, Martin J. Bligh wrote:
> Imagine we create a hybrid "u-k-space" with the protections of k-space, but the locality
> of u-space .... either by making part of the current k-space per task or by making part of
> the current u-space protected like k-space ... not sure which would be easier.
> 
> This u-k-space would be a good area for at least two things (and probably others):

That has been implemented in Caldera OpenUnix in the last years.
There was a nice overview paper by Steve Baumel and Rohit Chawla on this,
called "Managing More Physical With Less Virtual" which I think appeared
in some Y2000 Byte issue.

	Christoph

