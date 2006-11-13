Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755378AbWKMWT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbWKMWT0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 17:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755377AbWKMWT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 17:19:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16868 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1755375AbWKMWTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 17:19:25 -0500
Date: Mon, 13 Nov 2006 22:19:12 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Yu Luming <luming.yu@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
Subject: Re: [Patch] Adds backlight sysfs support for acpi video driver.
In-Reply-To: <200611110240.34715.luming.yu@gmail.com>
Message-ID: <Pine.LNX.4.64.0611132212230.2366@pentafluge.infradead.org>
References: <200611110240.34715.luming.yu@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Adds backlight sysfs support for acpi video driver.
> 
> signed-off-by: Luming Yu <Luming.yu@intel.com>

Ug. Watch out. Right now the backlight code requires framebuffer to be 
enabled. I seen a patch some time ago by Tony the allowed backlight 
support which I need to integrate. 

P.S
	It would be really nice if the acpi backlight could be exposed to 
the VESA framebuffer or any other driver whos backlight is not 
implemented. 
