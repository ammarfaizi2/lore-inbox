Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVGVR5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVGVR5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 13:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVGVR5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 13:57:06 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:12943 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262125AbVGVR5A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 13:57:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ouqNlU1ZwWvys4/ipwj4L7NjqJrYCEpOHPR35f4tTtfOs5yYfMNQNP3dxYqjlN/1rH/szaLLY0ZVsnF7WA+pGE8jTuvzATCKQIwbSgkH5LAZaequKFMC5djDopTNmFY3zupoRxeY5hwHn/mXLsIUlCIxvKMW7vx9U4x8rl6nubU=
Message-ID: <3faf056805072210563ed8f158@mail.gmail.com>
Date: Fri, 22 Jul 2005 23:26:58 +0530
From: vamsi krishna <vamsi.krishnak@gmail.com>
Reply-To: vamsi krishna <vamsi.krishnak@gmail.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: Whats in this vaddr segment 0xffffe000-0xfffff000 ---p ?
Cc: Bhanu Kalyan Chetlapalli <chbhanukalyan@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0507221154150.16740@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3faf0568050721232547aa2482@mail.gmail.com>
	 <7d15175e050722072727a7f539@mail.gmail.com>
	 <3faf0568050722081890a2e@mail.gmail.com>
	 <Pine.LNX.4.61.0507221154150.16740@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> It doesn't. The 32-bit machines never show 64 bit words in
> /proc/NN/maps. They don't "know" how.
> 
> b7fd6000-b7fd7000 rw-p b7fd6000 00:00 0
> b7ff5000-b7ff6000 rw-p b7ff5000 00:00 0
> bffe1000-bfff6000 rw-p bffe1000 00:00 0          [stack]
> ffffe000-fffff000 ---p 00000000 00:00 0          [vdso]
> ^^^^^^^^____________ 32 bits

hello john can you tell me what is [vdso], does it have any content
related file descriptor table it seems that the if I dont save this
segment during checkpointing,  the file open descriptors (i.e FILE *)
seems to have null after restoration.

Sincerely appreciate your inputs.

Cheers!
Vamsi
