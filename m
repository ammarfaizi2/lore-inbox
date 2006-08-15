Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWHOVl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWHOVl3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 17:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWHOVl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 17:41:29 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:22219 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750732AbWHOVl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 17:41:28 -0400
Date: Tue, 15 Aug 2006 23:36:46 +0200
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
Message-Id: <20060815233557.7F99.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2006-08-10 at 14:32 +0900, Yasunori Goto wrote:
> > Hello.
> > 
> > I would like to repost this patch to remove noisy useless message at boot
> > time from 2.6.18-rc4.
> > (I said "-mm doesn't shows this message in previous post", but it was wrong.
> >  This messages are shown by -mm too.)
> > 
> > -------------------------
> > This is to remove noisy useless message at boot time from 2.6.18-rc4.
> > The message is a ton of
> > "ACPI Exception (acpi_memory-0492): AE_ERROR, handle is no memory device"
> 
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

Ahhhhh. Yes. Indeed.
I had forgotten it.

But, I can't test it in this week due to I'm in vacation.
(Now, I'm writting this mail at hotel in vacation.)
Please wait until next week. :-P

Thanks.

-- 
Yasunori Goto 


