Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbTBUPJx>; Fri, 21 Feb 2003 10:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267503AbTBUPJx>; Fri, 21 Feb 2003 10:09:53 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:62684 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S267500AbTBUPJu>; Fri, 21 Feb 2003 10:09:50 -0500
Message-ID: <3E56438D.2020207@nortelnetworks.com>
Date: Fri, 21 Feb 2003 10:19:41 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: stephan@a2000.nu
Cc: linux-kernel@vger.kernel.org
Subject: Re: uptime reset on 2.4.11/12 (and maybe newer versions?) at +/- 500 days ?
References: <Pine.LNX.4.53.0302211004520.30745@ddx.a2000.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stephan@a2000.nu wrote:
> so maybe the uptime jumps back to zero at 497 days ?

jiffie rollover.

Take a 32-bit counter incrementing at 100Hz, and it will roll over in 
497.1 days.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

