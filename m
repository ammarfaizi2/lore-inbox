Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbTD3Om4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 10:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTD3Om4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 10:42:56 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:64011 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262189AbTD3Omt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 10:42:49 -0400
Date: Wed, 30 Apr 2003 15:55:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add a stub by which a module can bind to the AFS syscall
Message-ID: <20030430155507.A8897@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	David Howells <dhowells@redhat.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <25734.1051710294@warthog.warthog> <20030430150211.A7024@infradead.org> <20030430144638.GB25076@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030430144638.GB25076@gtf.org>; from jgarzik@pobox.com on Wed, Apr 30, 2003 at 10:46:38AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 10:46:38AM -0400, Jeff Garzik wrote:
> It's better than the alternative, having OpenAFS patch the system
> call table itself... ;-)

That's already taken care of with David's first patch.  There's no
reason we can't have an afsctlfs like the nfsctlfs.  But anyway,
please list the prototypes and usages of the subcalls here, maybe
some of them are generally usefull.

This kind of "I need a stuff fr a random syscall multiplexer"
requests are silly. APIs need review or you'll get the syssgi syndrome
really soon..

