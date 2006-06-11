Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWFKOOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWFKOOu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 10:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWFKOOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 10:14:49 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:33244 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750943AbWFKOOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 10:14:49 -0400
Message-ID: <448C2557.1000403@garzik.org>
Date: Sun, 11 Jun 2006 10:14:47 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [ANN] libata "chilled" for 2.6.18
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I won't use the word "frozen", so "chilled" is nearer the mark.  I just 
pulled Tejun's hotplug work into libata-dev.git#upstream (and thus 
#ALL).  This should be the last major API/probe-path/etc. disturbance 
until 2.6.18, and so, would be a good testing point.  Regenerate all 
your libata patches that broke :)

After merging some non-Tejun patches -- yes, others, I haven't forgotten 
you -- I'll post a full changelog and a patch that users can easily test.

	Jeff



