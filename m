Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272018AbRHVOic>; Wed, 22 Aug 2001 10:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272016AbRHVOiW>; Wed, 22 Aug 2001 10:38:22 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:43937
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S272015AbRHVOiH>; Wed, 22 Aug 2001 10:38:07 -0400
Message-ID: <3B83C430.7E5F59C3@nortelnetworks.com>
Date: Wed, 22 Aug 2001 10:39:44 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: why no call to add_interrupt_randomness() on PPC?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With all the talk about randomness, I went to see where my current system
(2.2.19 on PPC) was getting random numbers from.  I was kind of surprised to see
that there is no call to add_interrupt_randomness() in arch/ppc/kernel/irq.c.

Does anyone know why this call is not present in ppc_irq_dispatch_handler()? 
Would it be appropriate for me to make a patch for this?  Who would be the
appropriate person to send this to?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
