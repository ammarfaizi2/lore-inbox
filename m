Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287508AbSAUR1E>; Mon, 21 Jan 2002 12:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287588AbSAUR0z>; Mon, 21 Jan 2002 12:26:55 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:39332 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S287572AbSAUR0g>; Mon, 21 Jan 2002 12:26:36 -0500
Message-ID: <3C4C50C9.8C7D5B6F@nortelnetworks.com>
Date: Mon, 21 Jan 2002 12:32:57 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: yodaiken@fsmlabs.com
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com> <E16ShcU-0001ip-00@starship.berlin> <20020121095051.B14139@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yodaiken@fsmlabs.com wrote:

> So your claim is that:
>         Preemption improves latency when there are both kernel cpu bound
>         tasks and tasks that are I/O bound with very low cache hit
>         rates?
> 
> Is that it?
> 
> Can you give me an example of a CPU bound task that runs
> mostly in kernel? Doesn't that seem like a kernel bug?

cat /dev/urandom > /dev/null

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
