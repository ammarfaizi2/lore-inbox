Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbTLaWQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265266AbTLaWQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:16:57 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:23184 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S265265AbTLaWQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:16:56 -0500
Date: Wed, 31 Dec 2003 23:16:36 +0100
From: Manuel Estrada Sainz <ranty@debian.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Message-ID: <20031231221636.GN24577@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <200312210137.41343.dtor_core@ameritech.net> <1072169289.2876.57.camel@pegasus> <200312270025.24160.dtor_core@ameritech.net> <200312270028.26952.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200312270028.26952.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
X-SA-Exim-Mail-From: ranty@ranty.pantax.net
Subject: Re: [2.6 PATCH/RFC] Firmware loader fixes - take 2 (patch 1/2)
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 3.1 (built Wed Nov 26 20:40:04 CET 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 27, 2003 at 12:29:56AM -0500, Dmitry Torokhov wrote:
> ===================================================================
> 
> 
> ChangeSet@1.1527, 2003-12-25 22:44:59-05:00, dtor_core@ameritech.net
>   Firmware loader: correctly free allocated resources
>    - free allocated memory in class_device release method
>    - rely on sysfs to remove all attributes when device class
>      gets unregistered

 The problem is real, but I find the patch too intrusive.
 
 I'll try to fix the problem based on it.

 Thanks

 	Manuel
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
