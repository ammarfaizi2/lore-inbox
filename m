Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbTJCE2I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 00:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbTJCE2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 00:28:08 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:19419 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263660AbTJCE2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 00:28:06 -0400
Message-ID: <3F7CFAD1.4020003@nortelnetworks.com>
Date: Fri, 03 Oct 2003 00:28:01 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Christopher Friesen" <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: compiling futex-2.2
References: <3F7CED08.9080200@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friesen, Christopher [CAR:7Q26:EXCH] wrote:

As an alternate fix I tried wrapping the two function declarations with 
"ifdef __KERNEL__", and added the missing parm to the syscall in the 
futex library.  This seemed to work, so maybe this would be cleaner?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

