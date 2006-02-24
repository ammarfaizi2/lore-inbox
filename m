Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWBXIDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWBXIDh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 03:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWBXIDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 03:03:37 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:22229 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750954AbWBXIDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 03:03:36 -0500
Date: Fri, 24 Feb 2006 09:03:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ingo Molnar <mingo@elte.hu>
cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Gautam H Thaker <gthaker@atl.lmco.com>, linux-kernel@vger.kernel.org
Subject: Re: ~5x greater CPU load for a networked application when using
 2.6.15-rt15-smp vs. 2.6.12-1.1390_FC4
In-Reply-To: <20060223210844.GA26701@elte.hu>
Message-ID: <Pine.LNX.4.61.0602240902580.16630@yvahk01.tjqt.qr>
References: <43FE134C.6070600@atl.lmco.com> <20060223205851.GA24321@elte.hu>
 <29495f1d0602231306o55d759d5v9600b070a4b485e3@mail.gmail.com>
 <20060223210844.GA26701@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Would it make more sense to compare 2.6.15 and 2.6.15-rt17, as opposed 
>> to 2.6.12-1.1390_FC4 and 2.6.15-rt17? Seems like the closer the two 
>> kernels are, the easier it will be to isolate the differences.
>
>good point. I'd expect there to be similar 'top' output, but still worth 
>doing for comparable results.
>
I have seen this before too (with earlier -rt's), when MPlayer jumped from 
1.8% to about 10%. Maybe because it's using the rtc at 1024 Hz?


Jan Engelhardt
-- 
