Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVAJTsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVAJTsE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVAJTr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:47:59 -0500
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:63243 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262405AbVAJTcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:32:13 -0500
Date: Mon, 10 Jan 2005 20:34:26 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Simone Piunno <pioppo@ferrara.linux.it>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <20050110203427.5061cf0d.khali@linux-fr.org>
In-Reply-To: <200501102023.44847.pioppo@ferrara.linux.it>
References: <200501080150.44653.pioppo@ferrara.linux.it>
	<20050108172020.64999e50.khali@linux-fr.org>
	<200501082023.54881.pioppo@ferrara.linux.it>
	<200501102023.44847.pioppo@ferrara.linux.it>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simone,

> I've upgraded to the newest version available (f10), I have new values
> in  dmidecode, but nothing changed on the PWM behaviour.

OK, thanks for the update anyway. Please note that what I mainly need
now if a dump of your IT87xxF chip before ever loading the it87 driver.
As explained in a previous mail, you can obtain such a dump by running
"isadump 0x295 0x296". isadump is part of the lm_sensors package [1].

[1] http://secure.netroedge.com/~lm78/download.html

When I get this, I'll compare with the datasheets so as to understand
how your chip is configured (or left unconfigured) by your BIOS. This
will both help me propose a workaround in the it87 driver and explain
the Gigabyte support what I think they should do.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
