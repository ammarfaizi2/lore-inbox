Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbTCUFmb>; Fri, 21 Mar 2003 00:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263267AbTCUFmb>; Fri, 21 Mar 2003 00:42:31 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:35314 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S262646AbTCUFma>; Fri, 21 Mar 2003 00:42:30 -0500
Message-ID: <3E7AA8CD.8070708@nortelnetworks.com>
Date: Fri, 21 Mar 2003 00:53:17 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>
Cc: george anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Clock monotonic  a suggestion
References: <3E7A59CD.8040700@mvista.com> <20030321025045.GX2835@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker wrote:

> 	The issue for CLOCK_MONOTONIC isn't one of resolution.  The
> issue is one of accuracy.  If the monotonic clock is ever allowed to
> have an offset or a fudge factor, it is broken.  Asking the monotonic
> clock for time must always, without fail, return the exact, accurate
> time since boot (or whatever sentinal time) in the the units monotonic
> clock is using.

I thought that strictly speaking monotonic just meant that it never went backwards.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

