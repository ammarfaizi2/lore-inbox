Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262569AbRE3CF6>; Tue, 29 May 2001 22:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbRE3CFs>; Tue, 29 May 2001 22:05:48 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:1774 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S262564AbRE3CFi>;
	Tue, 29 May 2001 22:05:38 -0400
Message-ID: <3B145567.91C7A561@mandrakesoft.com>
Date: Tue, 29 May 2001 22:05:27 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Vier <tmv5@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac3: qlogic corruption on alpha
In-Reply-To: <20010529210958.A821@zero>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Vier wrote:
> 
> i narrowed down some corruption i was having. it only happens on drives
> attached to my qlogic isp card. 2.2 has no problem, and in 2.4.5-ac3 my
> sym53c875 works fine. this machine is an alpha miata. it only happens when
> writing out a lot to disk. eg, untarring a kernel tarball, restoring a
> backup. anyone else see this?

Also, what compiler are you using?  Depending on your current compiler,
switching to another compiler according to one of the following
permutations would be very instructive for us debugging the problem, at
least.

	gcc-2.96-RH -> gcc-2.95.3
	gcc-2.95.2 -> gcc-2.95.3
	gcc-2.95.3 -> egcs-1.1.2

Regards,

	Jeff


-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
