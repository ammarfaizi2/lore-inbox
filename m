Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263120AbVCEGRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263120AbVCEGRO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 01:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbVCEGHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 01:07:40 -0500
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:11017 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S263085AbVCDUpw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:45:52 -0500
Date: Fri, 4 Mar 2005 21:46:33 +0100
From: Jean Delvare <khali@linux-fr.org>
To: =?ISO-8859-1?Q? "Fr=E9d=E9ric?= L. W. Meunier" <2@pervalidus.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb blanks my monitor
Message-Id: <20050304214633.729d9fda.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.62.0503041415050.163@darkstar.example.net>
References: <Pine.LNX.4.62.0503022347070.311@darkstar.example.net>
	<1109823010.5610.161.camel@gaston>
	<Pine.LNX.4.62.0503030134200.311@darkstar.example.net>
	<1109825452.5611.163.camel@gaston>
	<Pine.LNX.4.62.0503031149280.311@darkstar.example.net>
	<42283AE5.9030700@linux-fr.org>
	<Pine.LNX.4.62.0503041415050.163@darkstar.example.net>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Frédéric, can you check in /etc/modprobe.conf if you have a 
> > line like: options i2c-algo-bit bit_test=1 If you do, please 
> > comment it out and see if it changes anything.
> 
> Yes, I had, but commenting it out didn't change anything.

I can confirm that. Adding bit_test=1 here did NOT cause any problem on
my two Radeon systems, so the problem you have isn't related to this
option. Sorry for the noise (but I guess it was still worth trying).

-- 
Jean Delvare
