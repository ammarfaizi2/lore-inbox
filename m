Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbVGMLD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVGMLD0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 07:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVGMLAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 07:00:16 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:32972 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262706AbVGMK7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:59:09 -0400
Date: Wed, 13 Jul 2005 12:58:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Wakko Warner <wakko@animx.eu.org>
cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
In-Reply-To: <20050712215332.GA31021@animx.eu.org>
Message-ID: <Pine.LNX.4.61.0507131256440.14635@yvahk01.tjqt.qr>
References: <20050710014559.GA15844@animx.eu.org>
 <E1DrRLL-00017G-00@calista.eckenfels.6bone.ka-ip.net> <20050710125438.GA17784@animx.eu.org>
 <42D253B5.20101@aitel.hist.no> <20050712215332.GA31021@animx.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Linux doesn't grow swapfiles at all.  It uses what's there at mkswap time.
>> You can make new ones of course - manually.
>
>And this part.  I've never known linux to grow the swap file.  I did try the
>sparse one a long time ago.  Of course it didn't work.

I can't remember where exactly I read it but: when swapon is called, a 
fixed-size(determined at swapon) bitmap of the swap blocks is generated (to 
cope with fragementation of swapfiles). 
Can somebody confirm this?


Jan Engelhardt
-- 
