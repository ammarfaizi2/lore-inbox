Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbUKJSFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbUKJSFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 13:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUKJSFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 13:05:34 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:21597 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262028AbUKJSF2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 13:05:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=d9vcqrF2eAnai90PFXtq8XT1EHpQLMpHmJXhuZ3PsgJLx61tjcmlHOJ8pJhCbkrxXIsXPkk5YLvz20ZU8XDkpoG6eTBov0tP2lutPPezwfmvwIpUucrOqwvqqheDg+qX2A4SHGyFpRwnQzJfkfRYMcb2RpLL6CPIo1Gikfs34qg=
Message-ID: <58cb370e04111010055ed26378@mail.gmail.com>
Date: Wed, 10 Nov 2004 19:05:28 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc64: Bump MAX_HWIFS in IDE code
Cc: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1100038365.3946.236.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041109203028.GA26806@krispykreme.ozlabs.ibm.com>
	 <20041109125507.4bc49b3c.akpm@osdl.org>
	 <20041109211201.GA8998@taniwha.stupidest.org>
	 <1100038365.3946.236.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton, IDE driver is limited to 10 major numbers anyway
so please just use 10 for now...

On Wed, 10 Nov 2004 09:12:45 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2004-11-09 at 13:12 -0800, Chris Wedgwood wrote:
> > On Tue, Nov 09, 2004 at 12:55:07PM -0800, Andrew Morton wrote:
> >
> > > hrmph.  That costs 50kbytes, excluding ide-tape.  It's worth a
> > > config variable, I think.
> >
> > this come up from time to time, and i wonder why it can't be dynamic?
> 
> Good question :) I suppose Bart has that on his todolist, but it will
> require some work on the IDE layer, which only few people can do without
> breaking it all :)

Yes I'm working on it and I will need some help with fixing PPC drivers. :)
