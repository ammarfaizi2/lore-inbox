Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269662AbUJSScJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269662AbUJSScJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270063AbUJSS1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:27:24 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:18913 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S269780AbUJSQz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 12:55:56 -0400
From: Russell Miller <rmiller@duskglow.com>
To: linux-kernel@vger.kernel.org
Subject: [MAKE/INSTALL] install bug
Date: Tue, 19 Oct 2004 11:59:32 -0500
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410191159.32754.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of 2.6.8.1, there was a small bug in the makefile.  To reproduce:  

Build a modules enabled kernel.
Make sure /lib/modules/2.6.whatever doesn't exist
Run make install.
It won't create the /lib/modules/2.6.whatever directory until you run make 
modules_install.

I think either:
It should tell you to run make modules_install first
or it should do it automatically.

Thanks,

--Russell

-- 

Russell Miller - rmiller@duskglow.com - Le Mars, IA
Duskglow Consulting - Helping companies just like you to succeed for ~ 10 yrs.
http://www.duskglow.com - 712-546-5886
