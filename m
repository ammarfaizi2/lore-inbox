Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTFQJIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 05:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbTFQJIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 05:08:36 -0400
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:50644 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id S261292AbTFQJHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 05:07:35 -0400
Message-ID: <3EEEDD98.8050201@dcrdev.demon.co.uk>
Date: Tue, 17 Jun 2003 10:21:28 +0100
From: Dan Creswell <dan@dcrdev.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Multicast "slow" on 2.5.69
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a multicast based application here that, essentially, consists of 
a server and client.  The client multicasts for the server which 
responds with a direct tcp connection back to the client (the client 
embeds it's IP address and port which the server should contact, in the 
multicast request).

Under 2.4.20 the server and client can be co-located on the same machine 
or run across the network successfully.

Under 2.5.69 a co-located client and server are slow to communicate - of 
the order of several minutes and if the server runs under 2.5.69 with 
the client on 2.4.20 on different machines, it doesn't seem to work at all.

So, I was wondering if anyone had any thoughts on what I should be 
looking at/for in this case?

Thanks,

Dan.


