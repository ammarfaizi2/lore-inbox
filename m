Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbUKCRxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbUKCRxF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 12:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUKCRxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 12:53:05 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:48809 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261790AbUKCRwx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 12:52:53 -0500
Message-ID: <41891AF3.9050800@verizon.net>
Date: Wed, 03 Nov 2004 12:52:51 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 5/5] documentation: Remove drivers/char/README.cycladesZ
References: <20041103152246.24869.2759.68945@localhost.localdomain> <20041103152314.24869.56459.88722@localhost.localdomain> <20041103133103.GB4109@logos.cnet>
In-Reply-To: <20041103133103.GB4109@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [68.238.31.6] at Wed, 3 Nov 2004 11:52:52 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're right.  I'll send a patch to put README.cycladesZ in Documentation/serial 
right now.

Marcelo Tosatti wrote:
> 
> Why is this obsolete? 
> 
> Users of Cyclades-Z still need to upload the firmware to the card.
> 
> I'm OK with removal of cyclomY.README.
> 
> On Wed, Nov 03, 2004 at 09:23:15AM -0600, james4765@verizon.net wrote:
> 
>>Remove obsolete file in drivers/char.
>>
>>Signed-off-by: James Nelson <james4765@gmail.com>
>>
>>diff -urN --exclude='*~' linux-2.6.9-original/drivers/char/README.cycladesZ linux-2.6.9/drivers/char/README.cycladesZ
>>--- linux-2.6.9-original/drivers/char/README.cycladesZ	2004-10-18 17:54:32.000000000 -0400
>>+++ linux-2.6.9/drivers/char/README.cycladesZ	1969-12-31 19:00:00.000000000 -0500
>>@@ -1,8 +0,0 @@
>>-
>>-The Cyclades-Z must have firmware loaded onto the card before it will
>>-operate.  This operation should be performed during system startup,
>>-
>>-The firmware, loader program and the latest device driver code are
>>-available from Cyclades at
>>-    ftp://ftp.cyclades.com/pub/cyclades/cyclades-z/linux/
>>-
>>-
