Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266058AbTLIT7A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 14:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266059AbTLIT7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 14:59:00 -0500
Received: from zeus.kernel.org ([204.152.189.113]:47249 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266058AbTLIT66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 14:58:58 -0500
Message-ID: <3FD62845.8090301@kubla.de>
Date: Tue, 09 Dec 2003 20:53:41 +0100
From: Dominik Kubla <dominik@kubla.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en, de
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Stephen Satchell <list@satchell.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Swap performance statistics in 2.6 -- which /proc file has it?
References: <BF1FE1855350A0479097B3A0D2A80EE00184D619@hdsmsx402.hd.intel.com>  <1070911748.2408.39.camel@dhcppc4>  <3FD546D5.2000003@nishanet.com>  <1070975964.5966.5.camel@ssatchell1.pyramid.net>  <Pine.LNX.4.53.0312090854080.8425@chaos> <1070981185.6243.58.camel@ssatchell1.pyramid.net> <Pine.LNX.4.53.0312091014250.525@chaos>
In-Reply-To: <Pine.LNX.4.53.0312091014250.525@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> If you need statistics v.s. time, you need to write an application
> that samples things at some fixed interval. In a previous life,
> I requested that "nr_free_pages()" be accessible from user-space,
> probably via /proc. That's all you need. Maybe that could be
> added now?  In any event, samping free pages at some fixed-time
> interval should give you all the information you need.

vmstat -a
sar -B
sar -r

O'Reilly's "System Performance Tuning" might make for an interesting read,
especially pages 110ff (also its Linux informations are a bit out of date).

Regards,
   Dominik Kubla
-- 
Those who can make you believe absurdities can make you commit
atrocities.    (Francois Marie Arouet aka Voltaire, 1694-1778)

