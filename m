Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264125AbTICRT2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTICRS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:18:26 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:57016 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264123AbTICRRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:17:37 -0400
Message-ID: <3F562225.4010609@nortelnetworks.com>
Date: Wed, 03 Sep 2003 13:17:25 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: given a struct sock, how to find pid of process that owns it?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm working on a small app similar to netstat that only cares about unix 
sockets.

I can easily walk /proc/net/unix, but to find the owner of the socket I 
need to scan /proc, which gets expensive.

Accordingly, I'd like to extend /proc/net/unix to also dump out the pid 
of the process that owns the socket.  The only thing is, I can't seem to 
figure out how to find the pid of the socket owner given a pointer to 
the socket struct.

Any tips?  Is it even there?

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com	

