Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131207AbRCWQS7>; Fri, 23 Mar 2001 11:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbRCWQSu>; Fri, 23 Mar 2001 11:18:50 -0500
Received: from colin.muc.de ([193.149.48.1]:40466 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id <S131207AbRCWQSf>;
	Fri, 23 Mar 2001 11:18:35 -0500
Message-ID: <20010323171716.28420@colin.muc.de>
Date: Fri, 23 Mar 2001 17:17:16 +0100
From: Andi Kleen <ak@muc.de>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: Adding just a pinch of icache/dcache pressure...
In-Reply-To: <20010323015358Z129164-406+3041@vger.kernel.org> <Pine.LNX.4.21.0103230403370.29682-100000@imladris.rielhome.conectiva> <20010323122815.A6428@win.tue.nl> <m1hf0k1qvi.fsf@frodo.biederman.org> <3ABB6833.183E9188@mandrakesoft.com> <20010323111056.A9332@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <20010323111056.A9332@cs.cmu.edu>; from Jan Harkes on Fri, Mar 23, 2001 at 05:10:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 05:10:56PM +0100, Jan Harkes wrote:
> btw. There definitely is a network receive buffer leak somewhere in
> either the 3c905C path or higher up in the network layers (2.4.0 or
> 2.4.1). The normal path does not leak anything.


What do you mean with "normal path" ? 

And are you sure it was a leak? TCP can buffer quite a bit of skbs, but it 
should be bounded based on the number of sockets. 


-Andi

