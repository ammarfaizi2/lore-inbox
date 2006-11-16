Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754831AbWKPVuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831AbWKPVuz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754833AbWKPVuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:50:54 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:30951 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1754831AbWKPVuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:50:54 -0500
Date: Thu, 16 Nov 2006 22:49:38 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Yitzchak Eidus <ieidus@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: changing internal kernel system mechanism in runtime by a module
 patch
In-Reply-To: <20061116192936.GF31879@stusta.de>
Message-ID: <Pine.LNX.4.61.0611162247560.12473@yvahk01.tjqt.qr>
References: <e7aeb7c60611161119h3e198e96va07d36d5b2dd6390@mail.gmail.com>
 <20061116192936.GF31879@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 16 2006 20:29, Adrian Bunk wrote:
>On Thu, Nov 16, 2006 at 09:19:50PM +0200, Yitzchak Eidus wrote:
>> is it possible to replace linux kernel internal functions such as
>> schdule () to lets say my_schdule ()  in a run time with a module
>> patch???

Nothing is impossible.

>> (so that every call in the kernel to schdule() will go to my_schdule()... ) 
>> ???
>> 
>> i am talking about a clean/standard way to do such thing

Not clean. Not standard.
And it sounds evil too.

>> (without overwrite the mem address of the function and replace it in a
>> dirty way...)
>
>No.

You would have to patch _every_ callsite. That's too tedious to be 
useful.

(Hey there is SMP alternatives which sounds like it did just that - 
anyone?)



	-`J'
-- 
