Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262605AbTDAPi6>; Tue, 1 Apr 2003 10:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262608AbTDAPi6>; Tue, 1 Apr 2003 10:38:58 -0500
Received: from imr1.ericy.com ([208.237.135.240]:54007 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id <S262605AbTDAPi5>;
	Tue, 1 Apr 2003 10:38:57 -0500
From: "Philippe Meloche (LMC)" <Philippe.Meloche@ericsson.ca>
To: davidel@xmailserver.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <3E89B55F.1010207@lmc.ericsson.se>
Date: Tue, 01 Apr 2003 10:50:55 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Process limits for epoll tests
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We tried to reproduce the tests you've done with /dev/epoll and we've 
come to ask us some questions.

1. How did you managed httperf to perform more than 1024 connections 
when it's using select() ?

2. Did you get some errors like client-timeout or connections reset when 
you were doing your tests ?

3. How much time did a burst test ( 27000 connections and 2 calls per 
connection ) last and how many sample did httperf
    took during those tests.

Thanks a lot

Philippe Meloche
philippe.meloche@lmc.ericsson.se
