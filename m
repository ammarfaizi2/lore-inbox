Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268506AbRGXW4J>; Tue, 24 Jul 2001 18:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268507AbRGXWz7>; Tue, 24 Jul 2001 18:55:59 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29412 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S268506AbRGXWzz>;
	Tue, 24 Jul 2001 18:55:55 -0400
Message-ID: <3B5DFD21.4C9CD01F@mandrakesoft.com>
Date: Tue, 24 Jul 2001 18:56:33 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Evan Parker <nave@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] null-deref errors for 2.4.7
In-Reply-To: <Pine.GSO.4.31.0107241528560.20515-100000@myth8.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Thanks.  Note that the null check in some of these cases is superfluous,
and the null check can be removed, instead of fixing the code to not
de-ref before the check.
-- 
Jeff Garzik      | "I use Mandrake Linux for the same reason I turn
Building 1024    |  the light switch on and off 17 times before leaving
MandrakeSoft     |  the room.... If I don't my family will die."
                 |            -- slashdot.org comment
