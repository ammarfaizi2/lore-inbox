Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbTEPSpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbTEPSpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:45:05 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:5869 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264539AbTEPSpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:45:04 -0400
Message-ID: <3EC534AD.5080604@nortelnetworks.com>
Date: Fri, 16 May 2003 14:57:49 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: help...where is my memory going? --soln found...sysv shared mem
References: <3EC52BC1.7070003@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some of the stuff that had already started up was using sysv shared memory 
segments, and they didn't get cleaned up properly.  Accounts for all the memory 
usage that I was trying to figure out.

Thought I'd post the solution in case anyone else gets hit by something similar.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

