Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264414AbUEYBNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbUEYBNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 21:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264422AbUEYBNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 21:13:24 -0400
Received: from mail.tpgi.com.au ([203.12.160.58]:57536 "EHLO mail2.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264414AbUEYBNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 21:13:23 -0400
Message-ID: <40B29AC1.7090807@linuxmail.org>
Date: Tue, 25 May 2004 11:00:49 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BUG: PSMouse doesn't survive suspend if compiled as module.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

A suspend2 user has noticed (and I've seen it myself) with kernel 2.6.6 
that psmouse support doesn't survive a suspend if it's compiled as a 
module. If compiled in, all is well. If it's not compiled in, a 
workaround is to rmmod and insmod the module.

Regards,

Nigel
-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

Evolution (n): A hypothetical process whereby infinitely improbable 
events occur
with alarming frequency, order arises from chaos, and no one is given 
credit.
