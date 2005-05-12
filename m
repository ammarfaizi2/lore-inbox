Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVELMXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVELMXS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 08:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVELMXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 08:23:18 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:38469 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261505AbVELMXG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 08:23:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T8LcydpOXBZKIRnT2thi0vzYt+bNLmyPc+4gVxm4rXRwcgzFlpxErECpAinWLcVZ2mnOnCW+hcfIjIFXGrWfJUbqZAAMUYylVQ4As3oApaUlMIy4YLZqG9wzTBYXz7Jx3qaiHUkH7jNwxiYAg3sAQJIzzvgPCNiJVRCeqLrQSQ4=
Message-ID: <1458d96105051205236e818ece@mail.gmail.com>
Date: Thu, 12 May 2005 17:53:04 +0530
From: SN <talk2sumit@gmail.com>
Reply-To: SN <talk2sumit@gmail.com>
To: Carlos Martin <carlosmn@gmail.com>
Subject: Re: USB Mass Storage
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <fe726f4e050512051439272c4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <1458d96105051201317c49500c@mail.gmail.com>
	 <fe726f4e050512051439272c4e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply Carlos and Eshwar.

So is it that IDE (ide-disk.c) doesn't even come into the picture?
>From where exactly is the data sent to the disk? I mean, where in
kernel would I find code for read/write on disk?

Thanks in advance.

Regards..

On 5/12/05, Carlos Martin <carlosmn@gmail.com> wrote:
> On 5/12/05, SN <talk2sumit@gmail.com> wrote:
> > If I use a USB connected hard-disk (IDE), which device driver would I
> > be using? I understand it is recognized as a SCSI disk. So, is it the
> > SCSI driver? Or would the IDE driver be used?
> 
>  You would use the usb-storage driver which in turn uses the scsi driver.
> 
>    cmn
> --
> Carlos Martín         http://www.cmartin.tk   http://rpgscript.berlios.de
> 
> "I'll wager it's the most extraordinary thing to happen round here
> since Queen Elizabeth's handmaid got hit by lightning and sprouted a
> beard"
>      -- T. C. Boyle, "Water Music"
>
