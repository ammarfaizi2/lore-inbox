Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVEaGPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVEaGPX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 02:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVEaGPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 02:15:23 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:55477 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261189AbVEaGPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 02:15:19 -0400
References: <1117291619.9665.6.camel@localhost>
            <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
            <84144f0205052911202863ecd5@mail.gmail.com>
            <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
            <1117399764.9619.12.camel@localhost>
            <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
            <1117466611.9323.6.camel@localhost>
            <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Machine Freezes while Running Crossover Office
Date: Tue, 31 May 2005 09:15:18 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.429C00F6.000011C6@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-30 at 10:31 -0700, Linus Torvalds wrote:
> Pekka, can you confirm that the SysRQ output in your original email was 
> from a "hung" time? Because that clearly shows that stuff is happening in 
> user space, which means that it's definitely not a kernel loop.

Yes. What I did was I booted to 2.6.12-rc5 and did all the traces (vmstat, 
oprofile, and Sysrq-P) in a row and saved them for the email. I do have 
other Sysrq-P traces where pipe_poll shows up quite a lot. 

Thanks for all the suggestions. I'll try them out hopefully later today and 
report back. 

                Pekka
