Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbUKWRxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUKWRxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 12:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUKWRvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:51:41 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:25096 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261384AbUKWRuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:50:22 -0500
Date: Tue, 23 Nov 2004 18:50:22 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: adm1026 driver port for kernel 2.6.10-rc2 (patch includes
 driver, patch to Kconfig, and patch to Makefile)
Message-Id: <20041123185022.54f6e069.khali@linux-fr.org>
In-Reply-To: <20041123165236.GA4936@penguincomputing.com>
References: <20041102221745.GB18020@penguincomputing.com>
	<NN38qQl1.1099468908.1237810.khali@gcu.info>
	<20041103164354.GB20465@penguincomputing.com>
	<20041118185612.GA20728@penguincomputing.com>
	<20041123165236.GA4936@penguincomputing.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Taking into account Arjan's comments, I have fixed the awkward
> locking constructs.  I have also switched from using MODULE_PARM()
> to module_param_array().  As Jean requested (and as I muttonheadedly
> ignored) on the last submission, the diff now includes the patches to 
> 
> .../drivers/i2c/chips/Makefile
> .../drivers/i2c/chips/Kconfig

Great, looks good enough to me. I'd like to see this patch applied to
the kernel. Any further change can be done through incremental patches,
which are so easier to review.

Thanks Justin for the good work :)

-- 
Jean Delvare
http://khali.linux-fr.org/
