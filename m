Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272061AbRHVRaY>; Wed, 22 Aug 2001 13:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272049AbRHVRaO>; Wed, 22 Aug 2001 13:30:14 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:56737
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S272062AbRHVRaC>; Wed, 22 Aug 2001 13:30:02 -0400
Message-ID: <3B83EC7B.B10F59C6@nortelnetworks.com>
Date: Wed, 22 Aug 2001 13:31:39 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: adding accuracy to random timers on PPC - new config option or runtime 
 overhead?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm looking at putting in PPC-specific code in add_timer_randomness() that would
be similar to the x86-specific stuff.

The problem is that the PPC601 uses real time clock registers while the other
PPC chips use a timebase register, so two different versions will be required.
Should I try and identify at runtime which it is (which would be extra
overhead), or should I add another config option to the kernel?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
