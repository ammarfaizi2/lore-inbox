Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312375AbSCUPsG>; Thu, 21 Mar 2002 10:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312376AbSCUPr5>; Thu, 21 Mar 2002 10:47:57 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:51090 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S312375AbSCUPrm>; Thu, 21 Mar 2002 10:47:42 -0500
Message-ID: <3C9A02CE.A177F8BC@nortelnetworks.com>
Date: Thu, 21 Mar 2002 10:57:02 -0500
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: last write to drive issued with write cache off?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was looking through the official spec on the IBM 120gxp drives (looking for
more info on the 333hr/mo thing) when the following sentence jumped out at me.

"To prevent loss of customer data, it is recommended that the last write access
before power off be issued after setting the write cache off."

I was curious if we're actually doing this when someone issues a shutdown
command. Anyone know?

Just wondering,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
