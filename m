Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263250AbREWUk7>; Wed, 23 May 2001 16:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263251AbREWUkj>; Wed, 23 May 2001 16:40:39 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:60589 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263250AbREWUk2>;
	Wed, 23 May 2001 16:40:28 -0400
Message-ID: <3B0C202E.AA9962AD@mandrakesoft.com>
Date: Wed, 23 May 2001 16:40:14 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
In-Reply-To: <Pine.LNX.4.31.0105231258420.6642-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Now, it may be that the preliminary patches from Andrea do not work this
> way. I didn't look at them too closely, and I assume that Andrea basically
> made the block-size be the same as the page size. That's how I would have
> done it (and then waited for people to find real life cases where we want
> to allow sector writes).

Due to limitations in low-level drivers, Andrea was forced to hardcode
4096 for the block size, instead of using PAGE_SIZE or PAGE_CACHE_SIZE.

-- 
Jeff Garzik      | "Are you the police?"
Building 1024    | "No, ma'am.  We're musicians."
MandrakeSoft     |
