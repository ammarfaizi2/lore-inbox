Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265964AbTGADS3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 23:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbTGADS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 23:18:28 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:17298 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265964AbTGADS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 23:18:27 -0400
Message-ID: <3F0100DE.1080105@nortelnetworks.com>
Date: Mon, 30 Jun 2003 23:32:46 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: simple question about signal.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In do_notify_parent() we fire off a signal to the parent of the process 
in question.  Then we explicitly wake up the parent.  Why?  Won't the 
process of sending the signal also wake up the parent?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

