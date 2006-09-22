Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWIVRM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWIVRM3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWIVRM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:12:29 -0400
Received: from main.gmane.org ([80.91.229.2]:28612 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964786AbWIVRM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:12:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: How to debug random bus errors?
Date: Fri, 22 Sep 2006 11:11:14 -0600
Message-ID: <ef15fm$uhs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inferno.cora.nwra.com
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're seeing programs die with "bus error" (SIGBUS) randomly on a dual 
processor Opteron machine.  I've run memtest86+ and cpuburn stress tests 
with no failure.  gdb on a core file seems uninteresting.  Is there some 
way to trace the kernel to try to get more insight?

Thanks!

-- 
Orion Poplawski
System Administrator                  303-415-9701 x222
NWRA/CoRA Division                    FAX: 303-415-9702
3380 Mitchell Lane                  orion@cora.nwra.com
Boulder, CO 80301              http://www.cora.nwra.com

