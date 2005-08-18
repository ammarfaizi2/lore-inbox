Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVHRMjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVHRMjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 08:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVHRMjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 08:39:04 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:22041 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932200AbVHRMjD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 08:39:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LLWaeqsPDixAgRNz6TGXjZku/+Wwtn2zWz+r3yzMsjsI+o9OxHBtJfzqmU7RvEFnAd1knhVBUu3z+pRY4zcZGiCyyOUDdWWjgqj/Dy2KHqpDK/G5TJ2Ji87G8YEk2wDzR4hojk5QmlnXSq6lu/S80e+684ogkbKE7ze/LrYyvus=
Message-ID: <7cd5d4b40508180538133ca00f@mail.gmail.com>
Date: Thu, 18 Aug 2005 20:38:58 +0800
From: jeff shia <tshxiayu@gmail.com>
To: jeff shia <tshxiayu@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: can I write to the cdrom through writing to the device file sr0?
In-Reply-To: <20050818100733.GA110@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <7cd5d4b4050818014042740322@mail.gmail.com>
	 <20050818100733.GA110@DervishD>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thank you ,DervishD.
another question:What is the difference between cdrtools and cdrecord?
It seems that the fomer is bigger.


On 8/18/05, DervishD <lkml@dervishd.net> wrote:
>    Hi Jeff :)
> 
>  * jeff shia <tshxiayu@gmail.com> dixit:
> > I want to write a cdrw user space driver just like cdreord,but the
> > cdrecord is too complex and huge!can I write to the cdrom through
> > writing to the device file sr0,here sr0 is the device file of the
> > cdrw.
> 
>    Although someone may say that the size of cdrecord is
> proportional to the author's ego, the crude reality is that cdrecord
> has to be such complex and huge (well, I don't think it is huge,
> but...). It has to be complex because cdwriting *is* complex. Take a
> look at the code and see if you can get rid of things. Nowadays I
> think that most of the writers out there are SCSI-3/MMC compliant, so
> you can just use that driver, but that won't probably remove much
> code.
> 
>    Try joining a cdrecord alternative. I don't remember the name,
> but a project to build a cd recording library exists.
> 
>    Raúl Núñez de Arenas Coronado
> 
> --
> Linux Registered User 88736 | http://www.dervishd.net
> http://www.pleyades.net & http://www.gotesdelluna.net
> It's my PC and I'll cry if I want to...
>
