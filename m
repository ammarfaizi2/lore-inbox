Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267679AbUIUNRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267679AbUIUNRa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 09:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUIUNRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 09:17:30 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:15634 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S267669AbUIUNR1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 09:17:27 -0400
Date: Tue, 21 Sep 2004 15:17:30 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: RARP support disapeard in kernel 2.6.x ?
In-Reply-To: <Pine.LNX.4.44.0409211359270.5322-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.60L.0409211511290.15099@rudy.mif.pg.gda.pl>
References: <Pine.LNX.4.44.0409211359270.5322-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-604658362-1095772650=:15099"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-604658362-1095772650=:15099
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 21 Sep 2004, Tigran Aivazian wrote:

> also, the manpage rarpd(8) says:
>
> OBSOLETES
>       This  rarpd obsoletes kernel rarp daemon present in Linux kernels up to
>       2.2 which was controlled by the rarp(8) command.
>
> which means the kernel version was removed much earlier.

# ps aux | grep rarpd
root      4563  0.0  0.0  1456  332 ?        Ss   15:02   0:00 /usr/sbin/rarpd
# rarp -a
This kernel does not support RARP.

Maybe I'm wrong but IIRC rarpd as same as arpd was only neccessary for 
large RARP table.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--8323328-604658362-1095772650=:15099--
