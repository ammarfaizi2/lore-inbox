Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268675AbRH0URl>; Mon, 27 Aug 2001 16:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268614AbRH0URa>; Mon, 27 Aug 2001 16:17:30 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:53000 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268792AbRH0URU>; Mon, 27 Aug 2001 16:17:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 22:24:04 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
In-Reply-To: <20010827155621Z16272-32385+261@humbolt.nl.linux.org> <516781015.998944596@[169.254.198.40]>
In-Reply-To: <516781015.998944596@[169.254.198.40]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827201728Z16121-32383+1728@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 27, 2001 09:36 pm, Alex Bligh - linux-kernel wrote:
> --On Monday, 27 August, 2001 6:02 PM +0200 Daniel Phillips 
> <phillips@bonn-fries.net> wrote:
> 
> > On the other hand, we
> > will penalize faster streams that way
> 
> Penalizing faster streams for the same number
> of pages is probably a good thing
> as they cost less time to replace.

Let me clarify, the stream is fast because its client is fast.  The disk will 
service the reads at the same speed for all the streams.  (Let's not go into 
the multi-disk case just now, ok?)

--
Daniel
