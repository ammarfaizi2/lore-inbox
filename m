Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbTDVQBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTDVQBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:01:12 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:18816 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S263227AbTDVQBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:01:11 -0400
Date: Tue, 22 Apr 2003 18:13:14 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: jgarzik@pobox.com
Cc: <linux-poweredge@dell.com>, <linux-kernel@vger.kernel.org>
Subject: 2.4.21-pre5 : hw tcp v4 csum failed
Message-Id: <20030422181314.4035b6f1.philippe.gramoulle@mmania.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws87 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I just saw that we've been having those messages on at least 4 DELL 2650 ( running tg3 driver version 1.4c)
running busy FTP servers ( all in the same load balanced FTP farm )

ftp1 # egrep -c "hw tcp v4 csum failed" /var/log/kern.log
1846

for the last 3 days.

The box is running 2.4.21-pre5.

Is this a known problem ? ( i've seen that driver 1.5 is available BTW)
or more likely a network issue ?

Thanks,

Philippe
