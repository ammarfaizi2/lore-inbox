Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVAMPuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVAMPuI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVAMPsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:48:04 -0500
Received: from fbxmetz.linbox.com ([81.56.128.63]:61333 "EHLO joebar.metz")
	by vger.kernel.org with ESMTP id S261685AbVAMPmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:42:47 -0500
Message-ID: <41E696F4.3070700@linbox.com>
Date: Thu, 13 Jan 2005 16:42:44 +0100
From: Ludovic Drolez <ludovic.drolez@linbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RAIT device driver feasibility
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'd like to know if it's easy to write a RAID like device for tapes (RAIT)...
For block devices, hooks are present in the kernel code, but for char devices, 
is there a way to implement a write function for example, which will write in 
parallel to N /dev/stX tape devices ?

RAIT already exists in Amanda, in user space, but I'd like to see a generic 
kernel RAIT driver which could be used by any backup program.

Cheers,

-- 
Ludovic DROLEZ                              Linbox / Free&ALter Soft
152 rue de Grigy - Technopole Metz 2000                   57070 METZ
tel : 03 87 50 87 90                            fax : 03 87 75 19 26
