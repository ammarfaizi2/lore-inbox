Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUIUS2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUIUS2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 14:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUIUS2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 14:28:13 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:34058 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S267890AbUIUS2I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 14:28:08 -0400
Date: Tue, 21 Sep 2004 20:28:13 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: RARP support disapeard in kernel 2.6.x ?
In-Reply-To: <cipqh4$g9d$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.60L.0409212019090.15099@rudy.mif.pg.gda.pl>
References: <Pine.LNX.4.44.0409211359270.5322-100000@localhost.localdomain><Pine.LNX.4.44.0409211359270.5322-100000@localhost.localdomain>
 <Pine.LNX.4.60L.0409211511290.15099@rudy.mif.pg.gda.pl> <cipqh4$g9d$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2020929991-1095791293=:15099"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2020929991-1095791293=:15099
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 21 Sep 2004, Bill Davidsen wrote:
[..]
>> # rarp -a
>> This kernel does not support RARP.
>> 
>> Maybe I'm wrong but IIRC rarpd as same as arpd was only neccessary for 
>> large RARP table.
>
> Is it possible that you are using an old version of the rarp command which is 
> trying to use the kernel RARP rather than using the rarpd?

Yes.
rarp from old net-tools still try to open /proc/net/rarp and depending on
not avalaibability this file prints above message.

Seem it is undocumented in kernel documentation from where can be 
downloaded new rarp tool. Anyone know from where it can be downloaded ?

Previously pointed rarpd also cant be compiled without few changes (last 
release this package was in 1999).

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--8323328-2020929991-1095791293=:15099--
