Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277409AbRJEQgY>; Fri, 5 Oct 2001 12:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277483AbRJEQgO>; Fri, 5 Oct 2001 12:36:14 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:26040 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S277409AbRJEQgA>; Fri, 5 Oct 2001 12:36:00 -0400
Message-ID: <3BBDE1AA.98C4712F@nortelnetworks.com>
Date: Fri, 05 Oct 2001 12:36:58 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkv@isg.de
Cc: "Kernel, Linux" <linux-kernel@vger.kernel.org>
Subject: Re: Desperately missing a working "pselect()" or similar...
In-Reply-To: <3BBDD37D.56D7B359@isg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkv@isg.de wrote:
> 
> Hi,
> 
> I'm currently looking for a decent method to wait on either
> an I/O event _or_ a signal coming from another process.

> - Unix domain sockets would be awkward to use due to the fact
>   I'd need to come up with some "filenames" for them to bind to,
>   and both security considerations and the danger of "leaking"
>   files that remain on disk forever make me shudder...
 
If you use a named socket in the abstract namespace, then it can't "leak" to
disk....

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
