Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161220AbWAHVqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161220AbWAHVqa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 16:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161221AbWAHVqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 16:46:30 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:8594 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161220AbWAHVq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 16:46:29 -0500
Date: Sun, 8 Jan 2006 22:46:22 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] It's UTF-8
In-Reply-To: <20060108203851.GA5864@mipter.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.61.0601082245090.17804@yvahk01.tjqt.qr>
References: <20060108203851.GA5864@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

I'd say ACK. However,

> iocharset=name	Character set to use for converting from Unicode to
> 		ASCII.  The default is to do no conversion.  Use
>-		iocharset=utf8 for UTF8 translations.  This requires
>+		iocharset=utf8 for UTF-8 translations.  This requires
> 		CONFIG_NLS_UTF8 to be set in the kernel .config file.

If you are really nitpicky about the "-", then it should also be 
"iocharset=utf-8" (and whereever else). Or what's the real purpose of 
adding the dashes in only half of the places, then?



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
