Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbTDPQA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbTDPQA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:00:59 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:18140 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264426AbTDPQA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:00:58 -0400
Date: Wed, 16 Apr 2003 18:06:06 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: jamal <hadi@cyberus.ca>, Catalin BOIE <util@deuroconsult.ro>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] qdisc oops fix
Message-ID: <20030416160606.GA32575@louise.pinerecords.com>
References: <20030415084706.O1131@shell.cyberus.ca> <Pine.LNX.4.53.0304160838001.25861@hosting.rdsbv.ro> <20030416072952.E4013@shell.cyberus.ca> <3E9D755A.8060601@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9D755A.8060601@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [manfred@colorfullife.com]
> 
> >>Trace; c0127e0f <kmalloc+eb/110>
> >>Trace; c01d3cac <qdisc_create_dflt+20/bc>
> >>Trace; d081ecc7 <END_OF_CODE+1054ff0f/????>
> >>Trace; c01d5265 <tc_ctl_tclass+1cd/214>
> >>Trace; d0820600 <END_OF_CODE+10551848/????>
> >>Trace; c01d27e4 <rtnetlink_rcv+298/3bc>
> >>Trace; c01d0605 <__neigh_event_send+89/1b4>
> >>Trace; c01d7cd4 <netlink_data_ready+1c/60>
> >>Trace; c01d7730 <netlink_unicast+230/278>
> >>Trace; c01d7b73 <netlink_sendmsg+1fb/20c>
> >>Trace; c01c79d5 <sock_sendmsg+69/88>
> >>Trace; c01c8b48 <sys_sendmsg+18c/1e8>
> >>Trace; c0120010 <map_user_kiobuf+8/f8>
> >>
> I don't understand the backtrace. Were any modules loaded? Perhaps 
> 0xd081ecc7 is a module.

The original backtrace as provided by Martin Volf does not contain
any weird addresses such as 0xd081ecc7 above:

http://marc.theaimsgroup.com/?l=linux-kernel&m=105013596721774&w=2

-- 
Tomas Szepe <szepe@pinerecords.com>
