Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWBXSSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWBXSSX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 13:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWBXSSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 13:18:23 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:55452 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932416AbWBXSSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 13:18:22 -0500
Date: Fri, 24 Feb 2006 19:18:19 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Martin Mares <mj@ucw.cz>
cc: Asfand Yar Qazi <ay0106@qazi.f2s.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 'vga=' parameter wierdness
In-Reply-To: <mj+md-20060224.181006.23057.albireo@ucw.cz>
Message-ID: <Pine.LNX.4.61.0602241915380.3694@yvahk01.tjqt.qr>
References: <43FC1624.8090607@qazi.f2s.com> <200602221130.13872.vda@ilport.com.ua>
 <43FC54B8.7070706@qazi.f2s.com> <mj+md-20060222.121130.6225.albireo@ucw.cz>
 <43FC574A.4000100@qazi.f2s.com> <Pine.LNX.4.61.0602240832150.16363@yvahk01.tjqt.qr>
 <mj+md-20060224.101038.705.atrey@ucw.cz> <Pine.LNX.4.61.0602241904570.3694@yvahk01.tjqt.qr>
 <mj+md-20060224.181006.23057.albireo@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> And making sure the vga selector (i.e. when booting with 
>> vga=ask) always prefix numbers with 0x when they are supposed to be in 
>> hexadecimal, i.e. e.g.
>>   for(i=0; ...) 
>>       printf("%#x   %dx%d\n", i, vga_modes[i].width, vga_modes[i].height);
>> instead of currently
>>       printf("%x    %dx%d\n", ...)
>
>However, this would change meaning of numbers entered at the video mode
>prompt (with vga=ask), which doesn't look good.
>
Add a warning ;-)



Jan Engelhardt
-- 
