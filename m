Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVA3TYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVA3TYS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 14:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVA3TYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 14:24:18 -0500
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:7258 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S261687AbVA3TYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 14:24:15 -0500
Date: Sun, 30 Jan 2005 20:24:10 +0100 (CET)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: chas3@users.sourceforge.net
Cc: Mike Westall <westall@cs.clemson.edu>,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Subject: Re: [Linux-ATM-General] Kernel 2.6.10 and 2.4.29 Oops fore200e (fwd)
In-Reply-To: <Pine.LNX.4.61L.0501250009240.9051@oceanic.wsisiz.edu.pl>
Message-ID: <Pine.LNX.4.61L.0501302022470.5761@oceanic.wsisiz.edu.pl>
References: <200501242238.j0OMcru4017742@ginger.cmf.nrl.navy.mil>
 <Pine.LNX.4.61L.0501250009240.9051@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005, Lukasz Trabinski wrote:

> Ok, i have just put udelay() function to the driver. If router will not crash 
> after 5-6 days, it mean that driver works fine. I will inform about
> it. Generally problems has stareted (frequently crashes) when we puted to 
> them more atm interfaces/VCs and router started forward more traffic and
> operated with two additional full bgp table.

OK, I think that dirver works much better with udelay() function.

[root@cosmos root]# uptime
  20:20:48 up 6 days, 23:25,  1 user,  load average: 0.03, 0.03, 0.00


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
