Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318292AbSG3Ns4>; Tue, 30 Jul 2002 09:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318293AbSG3Ns4>; Tue, 30 Jul 2002 09:48:56 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:28153 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318292AbSG3Nsz>; Tue, 30 Jul 2002 09:48:55 -0400
Date: Tue, 30 Jul 2002 09:52:18 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29
Message-ID: <20020730095218.C8978@redhat.com>
References: <20020730091140.A6726@infradead.org> <Pine.LNX.4.44.0207300637230.2599-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207300637230.2599-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Jul 30, 2002 at 06:40:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 06:40:43AM -0700, Linus Torvalds wrote:
> I think we can still change the stuff in 2.5.x, but I really want to start
> seeing some code, so that I'm not taken by surprise by something that
> obviously sucks.

Sorry, I was away last week.  I'm updating patches to 2.5.29, and should have 
them ready by the afternoon for people to comment on.  There are a couple of 
things to check on ia64 and x86-64 ABI-wise, and people need to comment on the 
in-kernel f_ops->read/write changes.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
