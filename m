Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbWEXFYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWEXFYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 01:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbWEXFYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 01:24:36 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:60639 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932568AbWEXFYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 01:24:36 -0400
Message-ID: <4473EE0B.1050403@garzik.org>
Date: Wed, 24 May 2006 01:24:27 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <44700ACC.8070207@gmail.com>	 <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com>	 <1148379089.25255.9.camel@localhost.localdomain>	 <4472E3D8.9030403@garzik.org> <9e4733910605232148sf87b62eq5362d520e43c2e70@mail.gmail.com>
In-Reply-To: <9e4733910605232148sf87b62eq5362d520e43c2e70@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 5/23/06, Jeff Garzik <jeff@garzik.org> wrote:
>> OTOH, I think a perfect video driver would be in kernel space, and do
>>
>> * delivery of GPU commands from userspace to hardware, hopefully via
>> zero-copy DMA.  For older cards without a true instruction set, "GPU
>> commands" simply means userspace prepares hardware register
>> read/write/test commands, and blasts the sequence to hardware at the
>> appropriate moment (a la S3 Savage's BCI).
> 
> You have to security check those commands in the kernel driver to keep
> normal users from using the GPU to do nasty things. Users can only
> play with memory that they own and no ones else's.

Obviously.

	Jeff



