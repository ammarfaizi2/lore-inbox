Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274368AbRJYOU2>; Thu, 25 Oct 2001 10:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274426AbRJYOUT>; Thu, 25 Oct 2001 10:20:19 -0400
Received: from gate.in-addr.de ([212.8.193.158]:59660 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S274368AbRJYOUN>;
	Thu, 25 Oct 2001 10:20:13 -0400
Date: Thu, 25 Oct 2001 16:22:00 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: concurrent VM subsystems
Message-ID: <20011025162200.D631@marowsky-bree.de>
In-Reply-To: <freemail.20010925100655.37794@fm3.freemail.hu> <3BD7F44C.7020007@ndsu.nodak.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
In-Reply-To: <3BD7F44C.7020007@ndsu.nodak.edu>; from "Reid Hekman" on 2001-10-25T06:15:24
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-10-25T06:15:24,
   Reid Hekman <reid.hekman@ndsu.nodak.edu> said:

> We've been over this already, while it would be nice for testing if the
> 
> two VM's could be compared without all the extra variables of the Linus
> and -ac trees it's not going to happen. It would be a big headache to 
> maintain all the extra source that would involve and all the changes to 
> other stuff you'd have to patch to make the two interchangeable. 

Now, this might be 2.5 material, but I think the subsystem should be
modularized; I think it has been proven that this part of the code is
definitely subject for discussion, and I would go as far as saying it just
might be possible that the optimal VM, catering to different approaches, plain
out doesn't exist, and that being able to switch VM personalities during
runtime would be useful.

Fortifying the subsystem borders would also make debugging and testing easier.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

