Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbTEMUK5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 16:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbTEMUK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 16:10:57 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:37131 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262310AbTEMUKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 16:10:52 -0400
Date: Tue, 13 May 2003 21:23:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [PATCH] in-core AFS multiplexor and PAG support
Message-ID: <20030513212335.A9213@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@warthog.cambridge.redhat.com>,
	David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	openafs-devel@openafs.org
References: <20030513170317.A29503@infradead.org> <8848.1052842356@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <8848.1052842356@warthog.warthog>; from dhowells@warthog.cambridge.redhat.com on Tue, May 13, 2003 at 05:12:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 05:12:36PM +0100, David Howells wrote:
> At what level? There're two levels of mux...
> 
>  (1) four syscalls
> 
>  (2) 30-ish pioctls, 40-ish control functions and 20-ish ICL functions.
> 
> If I go for (2) as I think you're suggesting, that's on the order of at least
> 90 new syscalls, probably more when Arla's additions are included...

As a first patch two pag syscalls.  After that please post an implementation
for every additional syscall you need to this list (or groups thereof) after
you moved most to an afsctl fs.


> > and do you really think this is a 2.6 thing?
> 
> Yes.

Care to explain why?  

