Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264165AbTKSWkT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 17:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264169AbTKSWkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 17:40:19 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:60903 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264165AbTKSWkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 17:40:16 -0500
Message-ID: <3FBBF148.20203@nortelnetworks.com>
Date: Wed, 19 Nov 2003 17:40:08 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: high res timestamps and SMP
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a requirement to have high-res timestamps available on SMP systems.

Assuming that we are running identical cpus, is a sync-up at boot time 
enough to give usable time values, or do I need to do force periodic 
re-syncs?

We're currently looking at MIPS, x86 (Xeons), and PPC.

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

