Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWAQUDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWAQUDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWAQUDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:03:52 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:22924 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964792AbWAQUDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:03:51 -0500
Date: Tue, 17 Jan 2006 21:03:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ismail Donmez <ismail@uludag.org.tr>
cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: Suggested janitor task - remove __init/__exit from function
 prototypes
In-Reply-To: <200601171901.57621.ismail@uludag.org.tr>
Message-ID: <Pine.LNX.4.61.0601172102390.11929@yvahk01.tjqt.qr>
References: <31582.1137291095@ocs3.ocs.com.au> <Pine.LNX.4.61.0601171754270.18569@yvahk01.tjqt.qr>
 <200601171901.57621.ismail@uludag.org.tr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Some function prototypes (in both .h and .c files) specify attributes
>> >like __init and __exit in the prototype.  gcc (at least at 3.3.3) uses
>> >the last such attribute that is actually specified, without issuing a
>> >warning.
>>
>> How does gcc 2.95 handle it, requiring __init in both spots?
>
>gcc 3.2 is now required for mainline kernel.
>
Sure, but I asked because I maintain one piece of code (ttyrpld) that 
should compile for both 2.4 and 2.6. OTOH, I could use it to make people 
convert to 2.6 ;-)


Jan Engelhardt
-- 
