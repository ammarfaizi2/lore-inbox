Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292914AbSB0TrQ>; Wed, 27 Feb 2002 14:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292917AbSB0Tqz>; Wed, 27 Feb 2002 14:46:55 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:37308 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S292913AbSB0TqX>; Wed, 27 Feb 2002 14:46:23 -0500
Message-ID: <3C7D3979.72D598C9@nortelnetworks.com>
Date: Wed, 27 Feb 2002 14:54:33 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: andre@linuxdiskcert.org
Subject: Re: [PATCH] Re: IDE error on 2.4.17
In-Reply-To: <20020227102544.GA3226@codepoet.org> <E16g5YG-0004gk-00@the-village.bc.nu> <20020227184758.GA9260@gondor.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann wrote:
> 
> On Wed, Feb 27, 2002 at 02:59:28PM +0000, Alan Cox wrote:
> > This is the wrong approach. That information is available properly if and
> > when the vendors install the smart utilities
> 
> Doesn't necessarily help. I recently saw a hard drive which made funny
> noises and got really slow reading some parts of the drive (~30MB/s on
> some parts, ~300kB/s on others), but ide-smart didn't report failed
> tests. Two days later the drive was dead...

I had two DTLA-series IBM drives.  Both of them started having problems, nothing
showed up on IBM's own bootable floppy based SMART tests, and both of them died
with no SMART warnings.

I'm not at all confident that SMART is all that useful.


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
