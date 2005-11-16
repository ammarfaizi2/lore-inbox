Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965251AbVKPNQC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251AbVKPNQC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbVKPNQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:16:02 -0500
Received: from mail.bmlv.gv.at ([193.171.152.37]:56508 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id S965251AbVKPNQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:16:00 -0500
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] optional use "gzip --rsyncable" for bzImage - 2
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Disposition: inline
Date: Wed, 16 Nov 2005 14:15:58 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200511161415.58844.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As (at least in debian) gzip has the "--rsyncable" parameter included, 
> I'd like to suggest this patch to (configurable) use this for bzImage 
creation.
> 
> The default is "N" to stay compatible with current behaviour.
> 
> 
> I didn't find an entry in MAINTAINERS; and according to git a lot of people 
> touch arch/i386/Kconfig, so I just send to the l-k.
> 
> Andrew, how about an -mm inclusion? Or is the patch too small to warrant 
that?


Sorry, my test compile just finished with an error.
I found that I misunderstood the way $(call ) works in kernel Makefiles;
I have to investigate that further.


Phil
