Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267253AbSLRO3Y>; Wed, 18 Dec 2002 09:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbSLRO3Y>; Wed, 18 Dec 2002 09:29:24 -0500
Received: from bozon.softax.pl ([62.89.75.130]:24539 "EHLO bozon.softax.com.pl")
	by vger.kernel.org with ESMTP id <S267253AbSLRO3Y>;
	Wed, 18 Dec 2002 09:29:24 -0500
Subject: heavy kupdated still observed in 2.4.18
From: Marcin Kasperski <Marcin.Kasperski@softax.com.pl>
To: linux-kernel@vger.kernel.org
Cc: Marcin.Kasperski@softax.com.pl
Content-Type: text/plain
Organization: Softax
Message-Id: <1040222242.7694.17.camel@cauchy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 15:37:22 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

{ I am not subscribed to linux-kernel, so be so kind to cc the replies
to me - although I will review the archives. I send this mail to report
that some problem still exists although it is considered to be solved }

I repeatably observe the effect of 'heavy kupdated' (kupdated taking
almost 100% CPU, computer not reacting - for a few seconds, happening 
from time to time). In the archives I found that this problem is
considered to be removed in 2.4.15per7
(http://hypermail.idiosynkrasia.net/linux-kernel/archived/2001/week48/0147.html). I use 2.4.18 and I still observe it.

Some (probably important) details:

- the effect happens in the particular case: when I perform large
copying over the local network (in fact it was sth like
    scp -r remote:/some/directory/tree ./ 
)
- I have a lot of RAM and there is a lot of free memory when the problem
is being observed
- I do not use any swap
- I use LVM (applied from lvm_1.0.5 as distributed by Sistina) and the
drive to which the copying occurs belongs to LVM volume group.




