Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSDWRk7>; Tue, 23 Apr 2002 13:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315278AbSDWRk6>; Tue, 23 Apr 2002 13:40:58 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:2693 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315277AbSDWRk5>; Tue, 23 Apr 2002 13:40:57 -0400
Message-ID: <3CC59124.576C5719@nortelnetworks.com>
Date: Tue, 23 Apr 2002 12:51:48 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
Cc: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: exporting task_nice in O(1)-sched
In-Reply-To: <20020423152749.GC1697@werewolf.able.es> <1019582164.1465.110.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Tue, 2002-04-23 at 11:27, J.A. Magallon wrote:
> 
> > Found this building bproc. New O(1) scheduler kills the nice field in
> > task struct. It gives a way to fix the niceness (set_user_nice()), but
> > the funtion to _query_ is not exported. Any particular reason ?
> 
> Probably because Ingo intended to hide as many interfaces to the
> scheduler as possible and only export those symbols that were needed.
> 
> It is safe to export if it is needed.

Seems kind of silly to be able to set it but not read it...

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
