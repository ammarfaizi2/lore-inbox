Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263992AbUCZKFn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 05:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbUCZKFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 05:05:43 -0500
Received: from village.ehouse.ru ([193.111.92.18]:53001 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S263992AbUCZKFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 05:05:40 -0500
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: "exit_aio:ioctx still alive" messages
Date: Fri, 26 Mar 2004 13:05:37 +0300
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403261305.37930.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I recompiled oracle with aio support on our development server one day ago. 
And now I see some messages in dmesg which I'd never seen before.

Is this something I should worry about?

rathamahata@dev src $ uname -r
2.6.5-rc2-aa2
rathamahata@dev src $ dmesg | grep exit_aio
exit_aio:ioctx still alive: 15 1 0
exit_aio:ioctx still alive: 87 1 0
exit_aio:ioctx still alive: 15 1 0
exit_aio:ioctx still alive: 3 1 0
exit_aio:ioctx still alive: 3 1 0
exit_aio:ioctx still alive: 5 1 0
exit_aio:ioctx still alive: 3 1 0
exit_aio:ioctx still alive: 5 1 0
exit_aio:ioctx still alive: 7 1 0
exit_aio:ioctx still alive: 7 1 0
exit_aio:ioctx still alive: 13 1 0
exit_aio:ioctx still alive: 9 1 0
exit_aio:ioctx still alive: 15 1 0
exit_aio:ioctx still alive: 517 1 0
exit_aio:ioctx still alive: 13 1 0
exit_aio:ioctx still alive: 3 1 0
exit_aio:ioctx still alive: 9 1 0
exit_aio:ioctx still alive: 7 1 0
exit_aio:ioctx still alive: 5 1 0
exit_aio:ioctx still alive: 9 1 0
exit_aio:ioctx still alive: 5 1 0
exit_aio:ioctx still alive: 7 1 0
exit_aio:ioctx still alive: 5 1 0
exit_aio:ioctx still alive: 5 1 0
exit_aio:ioctx still alive: 5 1 0
exit_aio:ioctx still alive: 5 1 0
exit_aio:ioctx still alive: 3 1 0
exit_aio:ioctx still alive: 5 1 0
exit_aio:ioctx still alive: 5 1 0
exit_aio:ioctx still alive: 3 1 0
exit_aio:ioctx still alive: 5 1 0
exit_aio:ioctx still alive: 13 1 0
exit_aio:ioctx still alive: 3 1 0
exit_aio:ioctx still alive: 25 1 0
exit_aio:ioctx still alive: 3 1 0
exit_aio:ioctx still alive: 81 1 0
exit_aio:ioctx still alive: 3 1 0
exit_aio:ioctx still alive: 9 1 0
exit_aio:ioctx still alive: 3 1 0
exit_aio:ioctx still alive: 75 1 0
exit_aio:ioctx still alive: 69 1 0
exit_aio:ioctx still alive: 101 1 0
exit_aio:ioctx still alive: 1897 1 0
exit_aio:ioctx still alive: 81 1 0
exit_aio:ioctx still alive: 15 1 0
rathamahata@dev src $

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
