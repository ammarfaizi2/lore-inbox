Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263427AbUJ2RWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbUJ2RWt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263382AbUJ2RTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:19:44 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:19053 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263383AbUJ2RPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:15:54 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm2
Date: Fri, 29 Oct 2004 19:16:00 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20041029014930.21ed5b9a.akpm@osdl.org>
In-Reply-To: <20041029014930.21ed5b9a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410291916.00687.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

Hi there,

kernel/intermodule.c:179: warning: `inter_module_register' is deprecated (declared at kernel/intermodule.c:38)
kernel/intermodule.c:180: warning: `inter_module_unregister' is deprecated (declared at kernel/intermodule.c:79)
kernel/intermodule.c:183: warning: `inter_module_put' is deprecated (declared at kernel/intermodule.c:160)
kernel/power/pm.c:201: warning: `pm_send' is deprecated (declared at kernel/power/pm.c:155)
kernel/power/pm.c:242: warning: `pm_send' is deprecated (declared at kernel/power/pm.c:155)
kernel/power/pm.c:259: warning: `pm_register' is deprecated (declared at kernel/power/pm.c:62)
kernel/power/pm.c:260: warning: `pm_unregister' is deprecated (declared at kernel/power/pm.c:86)
kernel/power/pm.c:261: warning: `pm_unregister_all' is deprecated (declared at kernel/power/pm.c:115)
kernel/power/pm.c:262: warning: `pm_send_all' is deprecated (declared at kernel/power/pm.c:234)
drivers/char/vt.c:748: warning: `pm_register' is deprecated (declared at include/linux/pm.h:106)
drivers/char/agp/backend.c:279: warning: `inter_module_register' is deprecated (declared at include/linux/module.h:577)
drivers/char/agp/backend.c:299: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:578)
drivers/char/drm/drm_agpsupport.h:431: warning: `inter_module_put' is deprecated (declared at include/linux/module.h:582)
drivers/char/drm/drm_drv.h:501: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
drivers/char/drm/drm_stub.h:183: warning: `inter_module_put' is deprecated (declared at include/linux/module.h:582)
drivers/char/drm/drm_stub.h:188: warning: `inter_module_unregister' is deprecated (declared at include/linux/module.h:578)
drivers/char/drm/drm_stub.h:255: warning: `inter_module_register' is deprecated (declared at include/linux/module.h:577)
drivers/parport/parport_pc.c:3193: warning: `MODULE_PARM_' is deprecated (declared at include/linux/module.h:562)
sound/core/init.c:261: warning: `pm_unregister' is deprecated (declared at include/linux/pm.h:111)
sound/core/init.c:776: warning: `pm_register' is deprecated (declared at include/linux/pm.h:106)

Is anyone fixing these?

Regards,
Boris.


