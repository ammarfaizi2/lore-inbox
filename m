Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbUDMEG5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 00:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbUDMEG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 00:06:57 -0400
Received: from [203.197.98.4] ([203.197.98.4]:17167 "EHLO avmx.iitkgp.ernet.in")
	by vger.kernel.org with ESMTP id S263193AbUDMEGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 00:06:54 -0400
Subject: KGDB problem
From: "kernel@cc.iitkgp.ernet.in" <kernel@cc.iitkgp.ernet.in>
Reply-To: kernel@cc.iitkgp.ernet.in
To: linux-kernel@vger.kernel.org
Cc: kgdb-bugreport@lists.sourceforge.net, amitkale@emsyssoft.com
Content-Type: text/plain
Organization: IIT Kharagpur
Message-Id: <1081829314.4021.11.camel@cs-rs-221.cse.iitkgp.ernet.in>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 Apr 2004 09:38:34 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

***********************************************
This Mail is Certified to be Virus Free.

CIC Network Security Group, IIT Kharagpur
***********************************************

I have a problem using kgdb.

My test kernel is 2.4.24 and I am using the kgdb patch
linux-2.4.23-kgdb-1.9.patch downloaded from kgdb.sourceforge.net.

The problem is that whenever I break at a function [say netif_rx() in a
net driver interrupt routine] and step into it, the "bt" (backtrace)
command never shows the entire stack trace - it only shows the current
function. Moreover, the "up" command does not work. Could anybody tell
me what could be the problem?

Regards.


