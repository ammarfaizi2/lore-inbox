Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWD3CbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWD3CbM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 22:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWD3CbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 22:31:12 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:54442 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750898AbWD3CbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 22:31:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QoKU3y9HjLeQ39qIFQPFP+EDe1itDPRcrOSxQP/UfkBTtIUqptiKVSvI0UmrYDicvg3C2PXPOZ1bH8v2pCkxSUCuZMS5JHwEU0TRAtVN59qJ2Wdua6DwtphWQfwBVK63zExRpEtElCk8iwkCo1YuFJSKoXBmRbMZbzELhaKb2jA=
Message-ID: <44542184.6030209@gmail.com>
Date: Sun, 30 Apr 2006 11:31:32 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: jason <huzhijiang@gmail.com>
CC: Jan Dittmer <jdi@l4x.org>, mogensv@vip.cybercity.dk, jgarzik@pobox.com,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: sata_sil24 resetting controller...
References: <20060427185813.GB6039@l4x.org> <4451594D.5060705@gmail.com>	 <4452AFAF.3000101@l4x.org> <4452B165.6090905@gmail.com>	 <445329A0.8020001@vip.cybercity.dk> <44533AA0.5060002@l4x.org> <380087de0604291922u476f23bdsf9cd95081e1378a5@mail.gmail.com>
In-Reply-To: <380087de0604291922u476f23bdsf9cd95081e1378a5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jason wrote:
> Jan Dittmer wrote
> 
> 
>> I shifted the sata card into a 66MHz, 32bit PCI slot now and the
>> problems went away. Just for the record, this is an Asus PU-DLS
>> mainboard with E7501 chipset. Now I can dd from all devices without
>> any error messages, giving me about 360mb/s continuous throughput for
>> 6 devices which isn't that bad I suppose.
>> The card gets assigned irq 22 in both configurations but in the
>> latter the irq is shared with the on-board usb-uhci controller
>> which somehow seems to work better...
> 
> push a 64bit+ 133Mhz+ non bridge PCI-X device into a 32bit slot? Is it 
> right?
> I am confused...
> 

Well, it's not optimal, but most PCI-X cards including sil3124 are 
backward compatible with PCI, so....

-- 
tejun
