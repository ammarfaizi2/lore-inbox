Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318333AbSG3Qv6>; Tue, 30 Jul 2002 12:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318347AbSG3Qv6>; Tue, 30 Jul 2002 12:51:58 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15703 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318333AbSG3Qv5>; Tue, 30 Jul 2002 12:51:57 -0400
Date: Tue, 30 Jul 2002 18:56:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc3aa4
Message-ID: <20020730165635.GJ1181@dualathlon.random>
References: <20020730060218.GB1181@dualathlon.random> <20020730094202.A7438@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020730094202.A7438@infradead.org>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 09:42:02AM +0100, Christoph Hellwig wrote:
> > Only in 2.4.19rc3aa4: 9900_aio-1.gz
> > 
> > 	Merged async-io from Benjamin LaHaise after purifying it from the
> > 	/proc/libredhat.so mess that made it not binary compatible with 2.5.
> 
> As there is no finished aio ABI for 2.5 it can't be binary compatible.  But
> unlike your version Ben's patch is not very likely to conflict with new

Yes, my version will clash if the API changes in 2.5, but I will adapt it with
whatever API will showup in 2.5. This is in developement process of course.
I just need to ship something right now and in order to do that without the
libredhat I've to risk to be incompatible for a short period of time.

> 2.5 features soon.  An no, there is no such thing as /proc/libredhat.so in
> his patch.

it may not be in /proc to save some byte of kernel ram but it doesn't matter
where such bytecode is located.

Andrea
