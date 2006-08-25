Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWHYMAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWHYMAN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 08:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWHYMAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 08:00:12 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:48583 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751158AbWHYMAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 08:00:10 -0400
Date: Fri, 25 Aug 2006 20:59:33 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: trenn@suse.de
Subject: Re: [PATCH](memory hotplug) Repost remove useless message at boot time from 2.6.18-rc4.
Cc: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>,
       keith mannthey <kmannth@us.ibm.com>,
       ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
In-Reply-To: <1155643418.4302.1154.camel@queen.suse.de>
References: <20060810142329.EB03.Y-GOTO@jp.fujitsu.com> <1155643418.4302.1154.camel@queen.suse.de>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.068
Message-Id: <20060825205423.0778.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I sent a patch a while ago that gets rid of the whole namespace walking
> by making acpi_memoryhotplug an acpi device and making use of the .add
> callback function and the acpi_bus_register_driver call.
> 
> I am not sure whether this is possible if you have multiple memory
> devices, though (if not maybe it should be made possible?)...
> 
> Yasunori even tested the patch and sent an Ok:
> http://marc.theaimsgroup.com/?t=114065312400001&r=1&w=2
> 
> If this is acceptable I can rebase the patch on a current kernel.

Hi. Thomas-san.
Did you rebase your patch?

I'm trying to do it now too. 
But, current code (2.6.18-rc4) seems to register handler for
only enable status devices at boot time.
So, notification is -discarded- due to no handler for new memory
device when hot-add event occurs. Hmmm. :-(


Bye.

-- 
Yasunori Goto 


