Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRAEHjQ>; Fri, 5 Jan 2001 02:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbRAEHjF>; Fri, 5 Jan 2001 02:39:05 -0500
Received: from ns1.megapath.net ([216.200.176.4]:37895 "EHLO megapathdsl.net")
	by vger.kernel.org with ESMTP id <S129415AbRAEHiy>;
	Fri, 5 Jan 2001 02:38:54 -0500
Message-ID: <3A5579CD.6050708@megapathdsl.net>
Date: Thu, 04 Jan 2001 23:37:49 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test12-pre8 i686; en-US; m18) Gecko/20001231
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0ac1
In-Reply-To: <3A556195.5090902@megapathdsl.net> <20334.978674744@kao2.melbourne.sgi.com> <20010105003107.C19392@ganymede.isdn.uiuc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Wendling wrote:

> Also sprach Keith Owens:
> } On Thu, 04 Jan 2001 21:54:29 -0800, 
> } Miles Lane <miles@megapathdsl.net> wrote:
> } >make[4]: Entering directory `/usr/src/linux/drivers/acpi'
> } >/usr/src/linux/Rules.make:224: *** Recursive variable `CFLAGS' references itself (eventually).  Stop.
> } 

> Changing that line to:
> 
> $(MODINCL)/%.ver: CFLAGS := -I./include $(CFLAGS)
> 
> might work as well...

Seems to work here.  Thanks, Bill.

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
