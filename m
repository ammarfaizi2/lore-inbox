Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310252AbSC2Sfj>; Fri, 29 Mar 2002 13:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310504AbSC2Sf2>; Fri, 29 Mar 2002 13:35:28 -0500
Received: from imladris.infradead.org ([194.205.184.45]:4360 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S310252AbSC2SfM>; Fri, 29 Mar 2002 13:35:12 -0500
Date: Fri, 29 Mar 2002 18:34:57 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: davidm@hpl.hp.com, Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic show_stack facility
Message-ID: <20020329183457.A4087@phoenix.infradead.org>
Mail-Followup-To: Christoph Hellwig <hch>, Andrew Morton <akpm@zip.com.au>,
	davidm@hpl.hp.com, Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020329160618.A25410@phoenix.infradead.org> <15524.40817.306204.292158@napali.hpl.hp.com> <3CA4A61A.A844E21B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2002 at 09:36:26AM -0800, Andrew Morton wrote:
> Here's the diff.  Comments?

I don't see who having to independand declaration in the same kernel
image are supposed to work..

I think you really want some HAVE_ARCH_SHOW_STACK define to disable
the generic version..

	Christoph

