Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265590AbUEZNVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUEZNVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265585AbUEZNVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:21:22 -0400
Received: from trantor.org.uk ([213.146.130.142]:24717 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S265686AbUEZNHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:07:55 -0400
Subject: Re: why swap at all?
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20040526123740.GA14584@citd.de>
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org>
	 <40B4590A.1090006@yahoo.com.au>
	 <200405260934.i4Q9YblP000762@81-2-122-30.bradfords.org.uk>
	 <40B467DA.4070600@yahoo.com.au> <20040526101001.GA13426@citd.de>
	 <40B47278.6090309@yahoo.com.au> <20040526105837.GA13810@citd.de>
	 <40B47D4C.6050206@yahoo.com.au>  <20040526123740.GA14584@citd.de>
Content-Type: text/plain
Message-Id: <1085576794.20025.5.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 14:06:45 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-26 at 13:37, Matthias Schniedermeyer wrote:
> On Wed, May 26, 2004 at 09:19:40PM +1000, Nick Piggin wrote:
> > Matthias Schniedermeyer wrote:
> > >On Wed, May 26, 2004 at 08:33:28PM +1000, Nick Piggin wrote:
> > 
> > OK, this is obviously bad. Do you get this behaviour with 2.6.5
> > or 2.6.6? If so, can you strace the program while it is writing
> > an ISO? (just send 20 lines or so). Or tell me what program you
> > use to create them and how to create one?
> 
> To use other words, this is the typical case where a "hint" would be
> useful.
> 
> program to kernel: "i read ONCE though this file caching not useful".

Wasn't their an O_STREAMING patch thrown around towards the beginning of
the 2.5 development cycle?

-- 
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

