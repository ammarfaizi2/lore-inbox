Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291143AbSBLPmu>; Tue, 12 Feb 2002 10:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291144AbSBLPmk>; Tue, 12 Feb 2002 10:42:40 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:46312 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S291143AbSBLPm3>; Tue, 12 Feb 2002 10:42:29 -0500
Message-ID: <3C6939A5.C8F3C3DB@nortelnetworks.com>
Date: Tue, 12 Feb 2002 10:49:57 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tulip oddity under 2.2.19 - possible bug?
In-Reply-To: <200202120033.g1C0X2b10435@wave.physics.adelaide.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Woithe wrote:
> 
> Hi all
> 
> [ Please CC me any replies since I read the list through a web archive which
>   sometimes misses messages ]
> 
> In recent times I have encounted an oddity while using a tulip-based NIC
> under 2.2.19.  I am wondering whether it's associated with a known issue or
> whether it's indicating a hardware fault of some description.

Have you tried the latest tulip drivers from www.scyld.com/network?  I've found
them to be best for the 2.2 series.

That said, there is still a race condition in the current driver that can cause
the tx queue to hang, but it's highly unlikely that you'll hit it at home (have
to be doing significant traffic in both directions to make it likely that you'll
hit it).

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
