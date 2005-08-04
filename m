Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262900AbVHEHb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262900AbVHEHb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 03:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVHEHb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 03:31:56 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:5897 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S262900AbVHEHbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 03:31:41 -0400
Message-ID: <42F29AC4.5030503@lougher.demon.co.uk>
Date: Thu, 04 Aug 2005 23:46:28 +0100
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Phillip Lougher <phil.lougher@gmail.com>, plougher@users.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: squashfs seems nfs-incompatible
References: <Pine.LNX.4.61.0508021710590.4634@yvahk01.tjqt.qr> <cce9e37e050804083347c138d4@mail.gmail.com> <Pine.LNX.4.61.0508050804090.19610@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0508050804090.19610@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> After a short flash of 
> idea and comparison, it turns out that squashfs is missing 
> sb->s_export->get_parent (the only requirement as it seems). Includes that you 
> have sb->s_export non-null, of course. sb->s_export can be set within 
> fill_super().
> 
> 

Ok, thanks.  I'll try and get a fix for it in the next release.

Regards

Phillip
