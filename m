Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWFXS1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWFXS1i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 14:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWFXS1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 14:27:38 -0400
Received: from narn.hozed.org ([209.234.73.39]:61148 "EHLO narn.hozed.org")
	by vger.kernel.org with ESMTP id S1751030AbWFXS1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 14:27:38 -0400
Date: Sat, 24 Jun 2006 13:27:37 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Change in-kernel afs client filesystem name to 'kafs'
Message-ID: <20060624182737.GQ5040@narn.hozed.org>
References: <20060624004154.GL5040@narn.hozed.org> <1151151360.3181.34.camel@laptopd505.fenrus.org> <20060624180136.GO5040@narn.hozed.org> <20060624180953.GA4145@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060624180953.GA4145@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 07:09:53PM +0100, Christoph Hellwig wrote:
> On Sat, Jun 24, 2006 at 01:01:41PM -0500, Troy Benjegerdes wrote:
> > Now, if you could suggest another way to have both the *experimental* 
> > in-kernel AFS client and OpenAFS client with mounted filesystems, please
> > let me know.
> 
> Don't do that.  Or at least stay far away from the vger lists with any
> bugreports or suggestions that come up when running OpenAFS.  It's some
> of the worst code around, and it has a license that doesn't event permit 
> the blatantly stupid poking into kernel internals it does.

I'm going to do it, but I know who to flame when OpenAFS breaks, and
it's not the kernel list. Believe me I've done it enough already.

Besides the syscall table modification, which is just plain stupid, is
there any other poking around in kernel internals the openafs code does
that shouldn't be there?

