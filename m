Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262866AbREVWPA>; Tue, 22 May 2001 18:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262867AbREVWOt>; Tue, 22 May 2001 18:14:49 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:11786 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S262866AbREVWOg>; Tue, 22 May 2001 18:14:36 -0400
Date: Tue, 22 May 2001 15:13:41 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: <arjan@fenrus.demon.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Xircom RealPort versus 3COM 3C3FEM656C
In-Reply-To: <m152Jn6-000Oh3C@amadeus.home.nl>
Message-ID: <Pine.LNX.4.33.0105221504520.15140-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2001 arjan@fenrus.demon.nl wrote:

> This sounds like a bug I have heard before: some switches don't work with
> the xircom card (well, our drivers for it) when doing full duplex.
> Could you try the latest driver from 
> 
> http://people.redhat.com/arjanv
> 
> which forces the card to half-duplex? 

I doesn't help, the switch still thinks it's running in full-duplex mode.
Performance is obviously the same.

The switch I have is not managed, so there is nothing I can do on that 
front. Any other suggestions?

[BTW, you've removed too many includes, the driver doesn't compile anymore 
in the 2.4.4-ac tree.]

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

