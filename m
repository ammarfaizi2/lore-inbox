Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVGLV72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVGLV72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVGLUvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:51:38 -0400
Received: from mail0.lsil.com ([147.145.40.20]:58820 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262411AbVGLUu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:50:57 -0400
Message-ID: <91888D455306F94EBD4D168954A9457C03157047@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: Tom Duffy <tduffy@sun.com>
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org
Subject: RE: [PATCH 22/82] remove linux/version.h from drivers/message/fus
		ion
Date: Tue, 12 Jul 2005 14:50:19 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sun, 2005-07-10 at 18:15 -0600, Moore, Eric Dean wrote:
> > I'd rather you not kill linux_compat.h file.
> > I use this file for compatibility of driver source 
> > across various kernel versions.  I provide our
> > customers with driver builds containing single source 
> > which needs to compile in kernels 2.6.5( e.g. SLES9),
> > 2.6.8 (e.g. RHEL4), and 2.6.11 ( e.g. SuSE 9.3 Pro).
> 
> It is the general policy that the source in the latest linux 
> kernel only
> supports that kernel.  You can certainly keep a compat header for your
> customers, but what is in kernel.org should be clean for that 
> version of
> the kernel.

Thanks for that info. But Id rather have same files in our maintained
driver,
and whats in the kernel tree.

> 
> > If you look at our 3.02.18 driver source I submitted to SuSE
> > for SLES9 SP2, you will see this file is about 3K bytes of
> > compatibility.  
> 
> Is the 3.02.18 code generally available now?  Can it be cleaned up for
> submission to 2.6.13?
> 


The 3.02.18 driver and the driver in kernel tree are totally different
drivers.
One thing is 3.02.18 has SAS support, and the kernel tree doesn't.    Id
wish
kernel folks would take our SAS drivers.

Eric Moore
