Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUCHQeh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 11:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbUCHQeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 11:34:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:40151 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262687AbUCHQee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 11:34:34 -0500
Date: Mon, 8 Mar 2004 08:34:33 -0800
From: cliff white <cliffw@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Recent Reaim results
Message-Id: <20040308083433.67485899.cliffw@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Test results from the OSDL reaim test. 
The -mm kernels now appear to be scaling a bit nice.
I dunno why, but the 8-ways like -mm2 :)

The is the 'database' load, a mixture of IO and CPU activity.

2-CPU - (all AS scheduler)

Kernel 			Max JPM		Percent change
linux-2.6.3		1266.95		0.0
2.6.4-rc1		1284.43		1.38
2.6.4-rc1-mm2		1316.93		3.90

4-CPU  ( all AS )
linux-2.6.3		5313.36		0.0
2.6.4-rc1		5218.87		-1.78
2.6.4-rc1-mm2		5391.00 	1.46

8-CPU (both) 
linux-2.6.3		8663,87		0.0 (deadline)
linux-2.6.3		8776.32		1.35 (AS)
2.6.4-rc1		8664.95		0.0 (deadline)
2.6.4-rc1		8795.75		1.57 (AS)
2.6.4-rc1-mm2		9405.53		8.62  (deadline)
2.6.4-rc1-mm2		9159.24		5.77  (AS) 

--------
cliffw
OSDL
http://	developer.osdl.org/cliffw/reaim  ( More results )
	


-- 
The church is near, but the road is icy.
The bar is far, but i will walk carefully. - Russian proverb
