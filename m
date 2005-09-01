Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbVIAT2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbVIAT2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965182AbVIAT2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:28:23 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:31625 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S965174AbVIAT2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:28:22 -0400
Message-ID: <4317564A.4020901@gmail.com>
Date: Thu, 01 Sep 2005 21:28:10 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/7] arch: pci_find_device remove
References: <200508292220.j7TMKbNC019793@wscnet.wsc.cz>
In-Reply-To: <200508292220.j7TMKbNC019793@wscnet.wsc.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby napsal(a):

>Set of patches, which removes pci_find_device from arch subtree.
>
> alpha/kernel/sys_alcor.c                |    3 ++-
> alpha/kernel/sys_sio.c                  |    6 +++---
> frv/mb93090-mb00/pci-frv.c              |    8 ++------
> frv/mb93090-mb00/pci-irq.c              |    4 +---
> ppc/kernel/pci.c                        |   21 +++++++++++----------
> ppc/platforms/85xx/mpc85xx_cds_common.c |   11 +++++++----
> sparc64/kernel/ebus.c                   |   17 ++++++-----------
> 7 files changed, 32 insertions(+), 38 deletions(-)
>  
>
Ok, nobody says nothing. So against what does Greg wants patches? 
vanilla? some git? These are against andrew's tree and it seems, that 
greg didn't accept them.

thanks,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

