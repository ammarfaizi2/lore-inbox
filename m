Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWBBQvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWBBQvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWBBQvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:51:35 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:11680 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932163AbWBBQvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:51:35 -0500
Date: Thu, 2 Feb 2006 17:51:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jiri Slaby <xslaby@fi.muni.cz>
cc: Arjan van de Ven <arjan@infradead.org>,
       kavitha s <wellspringkavitha@yahoo.co.in>, linux-kernel@vger.kernel.org
Subject: Re: root=LABEL= problem [Was: Re: Linux Issue]
In-Reply-To: <20060202105338.E921D22AF07@anxur.fi.muni.cz>
Message-ID: <Pine.LNX.4.61.0602021750510.13212@yvahk01.tjqt.qr>
References: <1138863068.3270.6.camel@laptopd505.fenrus.org>,
 <20060201114845.E41F222AF24@anxur.fi.muni.cz> <20060202105338.E921D22AF07@anxur.fi.muni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> > ds: no socket drivers loaded!
>>> > VFS: Cannot open root device "LABEL=/" or 00:00
>>> change root=LABEL=/ to root=/dev/XXX. Vanilla doesn't support this...
>>
>>ehhh??
>>sure it does.
>>
>>this is not a kernel feature, but an initrd feature, independent on
>>which kernel is used (there never was and is not a patch for this in any
>>distro kernel I know about)
>Ok, thank you for pointing that out.
>

So does someone have a kernel-side patch for enabling LABEL=? (Is the 
kernel even able to tell the label of a filesystem, or is that specific to 
mount(8)?)


Jan Engelhardt
-- 
