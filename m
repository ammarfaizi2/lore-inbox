Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262545AbRE3BSK>; Tue, 29 May 2001 21:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262548AbRE3BSA>; Tue, 29 May 2001 21:18:00 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:41709 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262545AbRE3BR5>;
	Tue, 29 May 2001 21:17:57 -0400
Message-ID: <3B144A39.8471B53E@mandrakesoft.com>
Date: Tue, 29 May 2001 21:17:45 -0400
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
> i narrowed down some corruption i was having. it only happens on drives
> attached to my qlogic isp card. 2.2 has no problem, and in 2.4.5-ac3 my
> sym53c875 works fine. this machine is an alpha miata. it only happens when
> writing out a lot to disk. eg, untarring a kernel tarball, restoring a
> backup. anyone else see this?

Is this reproducible?

A patch went into ac3 which attempts to address qlogicisp problems on
Alpha.  It originated from the nether regions deep inside Compaq,
original source unknown.  There is a -extraordinarily slight-
possibility this patch (which simply adds "mb()") causes problems. 
However, it is more likely that the patch is harmless but also useless,
not fixing the real problem.

Other questions - is your machine SMP?  How much RAM?

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
