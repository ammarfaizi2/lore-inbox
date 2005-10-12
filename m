Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVJLOhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVJLOhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 10:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVJLOhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 10:37:11 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:21962 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S964797AbVJLOhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 10:37:09 -0400
Date: Wed, 12 Oct 2005 16:36:57 +0200
From: Klaus Dittrich <kladit@arcor.de>
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: 2.6.14-rc* / xinetd
Message-ID: <20051012143657.GA1625@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SMP-system (2xP4)

I noticed a huge cpu usage of xinetd with 2.6.14-rc4 
starting with the first ntp request.

12:45:10 xeon2 xinetd[1245]: service dgram_time, recvfrom: Bad address (errno = 14)
12:45:40 xeon2 last message repeated 651771 times
12:46:41 xeon2 last message repeated 1329225 times
12:47:42 xeon2 last message repeated 1308902 times

2.6.13.3 works fine.
--
Klaus

