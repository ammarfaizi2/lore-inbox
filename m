Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSGVHSP>; Mon, 22 Jul 2002 03:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSGVHSP>; Mon, 22 Jul 2002 03:18:15 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:1411 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S316544AbSGVHSP>;
	Mon, 22 Jul 2002 03:18:15 -0400
From: irfan_hamid@softhome.net
To: linux-kernel@vger.kernel.org
Reply-To: irfan_hamid@softhome.net
Subject: Re: cli()/sti() clarification
Date: Mon, 22 Jul 2002 01:20:32 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.52.197.1]
Message-ID: <courier.3D3BB240.00001CDE@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thankyou all for explaining the system call internals to me. Feel like an 
idiot now :) 

Marco Colombo: As for what I am trying to achieve, it is simply this. I need 
to do plot extraction from radar raw returns. The scan time for one 
revolution is 2.44 secs. I need to extract plots for each pi/2 radians in 
less than 2.44/4 secs. I have already optimized the extraction algo upto 
SSE2 in assembly and am running the process as realtime, but it just cant 
seem to cut it. So now I am going to try and block interrupts while I do the 
DSP. 

Regards,
Irfan Hamid.
