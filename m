Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424217AbWKIWrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424217AbWKIWrX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424219AbWKIWrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:47:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:10471 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1424211AbWKIWrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:47:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fVkQ+iLAHWsEY/a+xNXBlPzJAjzsepueBxW8kq/PsykwmZObDLIIEToCrTesZYrAnbQt6B8r6Ve/zFq4bw2eOM7lIl9QFLPo3QqZlpFtz55NvaPWwsqijp0XLFhANE+ZLWxT5/JcSym8PgVKwWKZMMiQs17f+l4UvjxbnfiHL78=
Message-ID: <4553AFEE.1070504@gmail.com>
Date: Fri, 10 Nov 2006 07:47:10 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Monty Montgomery <monty@xiph.org>
CC: Brice Goglin <Brice.Goglin@ens-lyon.org>,
       Jens Axboe <jens.axboe@oracle.com>,
       Gregor Jasny <gjasny@googlemail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Douglas Gilbert <dougg@torque.net>
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com>	 <20061030114503.GW4563@kernel.dk>	 <9d2cd630610300517q5187043eieb0880047ddd03eb@mail.gmail.com>	 <20061030132745.GE4563@kernel.dk> <4552F905.3020109@ens-lyon.org>	 <45533468.1060400@gmail.com> <806dafc20611091209s5864c9eam77a9290194de343d@mail.gmail.com>
In-Reply-To: <806dafc20611091209s5864c9eam77a9290194de343d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Monty Montgomery wrote:
[--snip--]
>>  Kernel
>> and libata can't do much about it.  So, please find other way to detect
>> interface.
> 
> Just to be clear-- it is the kernel at fault here, and the kernel can
> do something about it-- but only if the kernel gets fixed.  Also to be
> clear, given this brokenness, yes I need to find another way.

Yeap, it seems to be kernel's fault and we need to fix both.

> Dammit, dammit, dammit, one step forward, two steps back :-(

:-(

-- 
tejun
