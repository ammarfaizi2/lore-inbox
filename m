Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285604AbRLGWLB>; Fri, 7 Dec 2001 17:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285606AbRLGWKv>; Fri, 7 Dec 2001 17:10:51 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:53204 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S285604AbRLGWKc>; Fri, 7 Dec 2001 17:10:32 -0500
Message-ID: <3C113F33.B310CB10@nortelnetworks.com>
Date: Fri, 07 Dec 2001 17:14:11 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davidm@hpl.hp.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>, j-nomura@ce.jp.nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
In-Reply-To: <3C103A1E.2524A7B7@zip.com.au> <Pine.LNX.4.21.0112071651360.22868-100000@freak.distro.conectiva> <15377.13976.342104.636304@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
> 
> >>>>> On Fri, 7 Dec 2001 16:52:07 -0200 (BRST), Marcelo Tosatti <marcelo@conectiva.com.br> said:
> 
>   Marcelo> I'm really not willing to apply this kludge...
> 
> Do you agree that it should always be safe to call printk() from C code?

Is it really safe to call this from interrupt handlers?  I can think of cases
where the time required to print can totally mess stuff up...

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
