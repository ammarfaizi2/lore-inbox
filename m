Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSG2LJX>; Mon, 29 Jul 2002 07:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSG2LJX>; Mon, 29 Jul 2002 07:09:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:48142 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315257AbSG2LJV>; Mon, 29 Jul 2002 07:09:21 -0400
Message-ID: <3D4521F5.3070306@evision.ag>
Date: Mon, 29 Jul 2002 13:07:33 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
       martin@dalecki.de
Subject: Re: cli/sti removal from linux-2.5.29/drivers/ide?
References: <200207290026.RAA00298@baldur.yggdrasil.com> <1027943789.842.25.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mon, 2002-07-29 at 01:26, Adam J. Richter wrote:
> 
>>	I have not seen any new IDE patches on lkml since 2.5.29 was
>>released, nor have I seen any other IDE patches that fix this.  Sorry
>>if I missed a message about it.
> 
> 
> I've been through them and I have a set but I've not been able to verify
> they are correct as they relate to vesa/eisa/isa stuff I don't posess.
> 
> Martin - is the host lock held when the tuning function is called ?

Unfortunately not. Not right now. But if you are fixing something
beneath - please "pretend" it is, since it should :-).

