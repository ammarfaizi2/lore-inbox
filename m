Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbUB0SPu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbUB0SPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:15:50 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:36513 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263082AbUB0SPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:15:49 -0500
Message-ID: <403F894C.1050808@nortelnetworks.com>
Date: Fri, 27 Feb 2004 13:15:40 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Why no interrupt priorities?
References: <F760B14C9561B941B89469F59BA3A8470255F02D@orsmsx401.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:

> If a device later in the handler chain is also interrupting, then the
> interrupt will immediately trigger again. The irq line will remain
> asserted until nobody is asserting it.

I thought I saw examples of edge-triggered shared interrupts earlier in 
the thread.  Doesn't that give the reason for this behaviour?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

