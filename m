Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbVKQEAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbVKQEAS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 23:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbVKQEAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 23:00:18 -0500
Received: from [69.90.147.196] ([69.90.147.196]:18913 "EHLO mail.kenati.com")
	by vger.kernel.org with ESMTP id S1161126AbVKQEAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 23:00:17 -0500
Message-ID: <437C0086.1060202@kenati.com>
Date: Wed, 16 Nov 2005 20:01:10 -0800
From: Carlos Munoz <carlos@kenati.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with fcc_enet driver for MPC8248 (2.6.12)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on an embedded board that is currently running kernel 2.4.28 
without any problems. However, I am trying to upgrade from kernel 2.4.28 
to kernel 2.6.12 and I'm unable to get the fcc_enet driver to work properly.
The fcc ports are connected to ethernet phy devices. The receive and 
transmitted data out of the ethernet phy devices is all 0xff.

I tried using the fcc_enet driver from the 2.4.28 kernel on the 2.6.12 
kernel but get the same results. This leads me to believe that the core 
initialization of the MPC8248 has changed on kernel 2.6.12.

Has anyone got the  fcc ports to work properly on the 2.6.12 kernel ? If 
yes, how ? Did the MPC8248 core initialization change ?

Thanks,


Carlos Munoz
