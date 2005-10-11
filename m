Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVJKNVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVJKNVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 09:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVJKNVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 09:21:41 -0400
Received: from pinea.xerox.fr ([217.109.185.18]:14507 "EHLO pinea.xerox.fr")
	by vger.kernel.org with ESMTP id S1751154AbVJKNVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 09:21:40 -0400
Message-ID: <434BBC63.6040800@xrce.xerox.com>
Date: Tue, 11 Oct 2005 15:21:39 +0200
From: "Le Lain, Olivier" <olivier.lelain@xrce.xerox.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12 and gcore
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

First, sorry if it's not the right place but after having googling for 
days, I didn't succed in finding some infos.

Since the kernel 2.6.12 (at least every 2.6.12 from Fedora Core 3) , I'm 
unable to generate useful core dumps with gcore.
I always have the following messages :

warning: The current VSYSCALL page code requires an existing execuitable.
Use "add-symbol-file-from-memory" to load the VSYSCALL page by hand

Then ,indeed, there no more symbols included in my core files, which 
makes them useless.

Is this a security issue ? (selinux is disabled) , a gdb one ? (gdb 
hasn't been updated since quite a long time )
Does someone know if there's an issue for that (a lot of my admin 
scripts rely on gcore so this is really annoying)
I havn't  this problem with 2.6.11 kernels but 2.6.12 solved a lot of 
other bugs so I'd rather use it.

Thanks.

-- 
Cordialement / Cheers.
 
-Olivier
CNS

