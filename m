Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265397AbTFMNvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 09:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbTFMNvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 09:51:15 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:42418 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265397AbTFMNvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 09:51:14 -0400
Message-ID: <3EE9DA08.2020707@nortelnetworks.com>
Date: Fri, 13 Jun 2003 10:04:56 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Bernd Eckenfels <ecki-lkm@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make gcc3.3 Eliminate Unused Static Functions
References: <E19Qeoz-0004CM-00@calista.inka.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:

> does that mean the current linux source tree does not benefit in any way
> from this patch?

I suspect that currently all such instances are wrapped in #ifdef and are not 
currently compiled in. As he said in the original message,  "it'd be nice to 
discard unused functions (think CONFIG_PROC_FS=n) without needing to #ifdef 
around them."

This would allow us to remove those #ifdefs.

Chris





-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

