Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbUKSHCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbUKSHCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 02:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbUKSHB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 02:01:26 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52703 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261277AbUKSHBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 02:01:17 -0500
Date: Fri, 19 Nov 2004 08:01:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bryan Henderson <hbryan@us.ibm.com>
cc: Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz, torvalds@osdl.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <OFA311AC16.4350B724-ON88256F50.0065969A-88256F50.00677F64@us.ibm.com>
Message-ID: <Pine.LNX.4.53.0411190800470.16171@yvahk01.tjqt.qr>
References: <OFA311AC16.4350B724-ON88256F50.0065969A-88256F50.00677F64@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>but I
>>think usually you have lot's of virtual memory (4Gbyte per process),
>>so killing off processes to get more of it makes no sense.
>
>I think it's fair to say you have 4G of virtual address space per process,
>but try to store 4G of information per process in it, and you will
>probably find you can't.  What's essentially scarce is swap space. Killing
>off processes frees up swap space.

3G in the default case, because there's 1G for kernel space.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
