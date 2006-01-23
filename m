Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964820AbWAWFti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbWAWFti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 00:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWAWFti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 00:49:38 -0500
Received: from ns2.suse.de ([195.135.220.15]:22680 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964820AbWAWFth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 00:49:37 -0500
Date: Mon, 23 Jan 2006 06:49:27 +0100
From: Nick Piggin <npiggin@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [rfc] split_page function to split higher order pages?
Message-ID: <20060123054927.GA9960@wotan.suse.de>
References: <20060121124053.GA911@wotan.suse.de> <1137853024.23974.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137853024.23974.0.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2006 at 03:17:04PM +0100, Arjan van de Ven wrote:
> On Sat, 2006-01-21 at 13:40 +0100, Nick Piggin wrote:
> > Hi,
> > 
> > Just wondering what people think of the idea of using a helper
> > function to split higher order pages instead of doing it manually?
> 
> Maybe it's worth documenting that this is for kernel (or even
> architecture) internal use only and that drivers really shouldn't be
> doing this..

I guess it doesn't seem like something drivers would need to use
(and none appear to do anything like it).

I'll add a note.

