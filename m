Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTETWLZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbTETWLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:11:24 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:23782 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261280AbTETWLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:11:24 -0400
Subject: Problem with routing in the IPv6 stack
From: celestar@t-online.de (Frank Victor Fischer)
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1053469464.2637.10.camel@darkstar.fischer.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 21 May 2003 00:24:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello out there,

I have encountered the following error message when trying to set up a
new entry in the IPv6 routing table with the command "ip -6 route add":

RTNETLINK answers: Cannot allocate memory

This has happened after I have had a working IPv6 configuration for
several days, and the error message is independent from the interface on
which I am trying to establish the route on.

No information at all has been recorded in the system logs by the
kernel, however I have straced the command which did not reveal any
useful information either. I backed up the results of the strace as well
as the /proc/net/ and /proc/sys/net/ trees, along with the ifconfig.

This occured the following platform:
AMD Duron 800 with 256 MB 133 MHz SDR-SDRAM
vanilla linux kernel 2.4.20 patches with XFS 1.2 and IPsec 1.98b.

I am not subscribed to the list so it would be most helpful if you
included me in the CC: list.

Thanks in advance, 
Victor (celestar@t-online.de)

