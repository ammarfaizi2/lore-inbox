Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVA0VTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVA0VTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVA0VTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:19:44 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:41161 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261181AbVA0VQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:16:58 -0500
Message-ID: <41F95A42.40001@drzeus.cx>
Date: Thu, 27 Jan 2005 22:16:50 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: PNP and bus association
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently tried out adding PNP support to my driver to remove the 
hassle of finding the correct parameters for it. This, however, causes 
it to show up under the pnp bus, where as it previously was located 
under the platform bus.

Is the idea that PNP devices should only reside on the PNP bus or is 
there some magic available to get the device to appear on several buses? 
It's a bit of a hassle to search in two different places in sysfs 
depending on if PNP is used or not.

Also, the PNP bus doesn't really say that much about where the device is 
physically connected. The other bus types usually give a hint about this.

Rgds
Pierre
