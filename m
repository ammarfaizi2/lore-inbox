Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVBSNxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVBSNxa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 08:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVBSNxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 08:53:30 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:44346 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261715AbVBSNx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 08:53:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=INzRpWOcZgQH5pUgEAhevPvBUk7xUoCBz5cZtlZ4L7lNpE/I/NamBDmj3YMxAJuvTGuX4ucsRRONbz9jnzERjC+vQTuWhmyOKqqXdyxMTJMhRPE8Y7vqTuHili/4d2LKibW3RNQ1Jo6j1agBuLRqwbsWft5kto9dhySDcxkxMMw=
Message-ID: <58cb370e050219055337ca9d62@mail.gmail.com>
Date: Sat, 19 Feb 2005 14:53:26 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: FAUmachine: Looking for a good documented DMA bus master capable PCI IDE Controller card
In-Reply-To: <20050219132606.GH16858@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050219102410.GD16858@cip.informatik.uni-erlangen.de>
	 <58cb370e05021903481de251df@mail.gmail.com>
	 <20050219132606.GH16858@cip.informatik.uni-erlangen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Feb 2005 14:26:07 +0100, Thomas Glanzmann
<sithglan@stud.uni-erlangen.de> wrote:
> Hello Bartlomiej,
> 
> > In IDE you have 2 devices per port and usually 2 ports per PCI device.
> > There are some controller cards with 4 ports but they don't have public
> > available documentation etc. I really wonder what are you trying to
> > achieve and why just can't you use more than 1 "virtual" PIIX crontoller.
> 
> we implemented the PIIX controller as part of an Intel Southbridge
> 82371AB[1] Chip so I didn't thought that it was also available as
> seperate PCI Device. Do you have any pointers to products or better
> sepcification of this products?

Nope.

> If this is the case that would be the best solution for our problem.

Hm, maybe you will have to implement some PCI add-on IDE controller,
AFAIR Silicon Image 680 datasheet is publicly available now.

Bartlomiej
