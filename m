Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTFPUq0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264281AbTFPUqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:46:25 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:59564 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264292AbTFPUqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:46:21 -0400
Message-ID: <3EEE2FD4.6060207@nortelnetworks.com>
Date: Mon, 16 Jun 2003 17:00:04 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: is it expected behaviour to receive one's own broadcast messages?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an app that is sending out broadcast messages to the local network using 
255.255.255.255.  It is registered for INADDR_ANY.  The thing that seems strange 
is that it receives a copy of every packet that it sends out.  Is this expected?

The kernel is 2.4.18.

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: 
cfriesen@nortelnetworks.comnetdev@oss.sgi.comnetdev@oss.sgi.com

