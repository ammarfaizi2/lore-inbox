Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWEKTXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWEKTXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 15:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWEKTXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 15:23:17 -0400
Received: from linux.dunaweb.hu ([62.77.196.1]:45704 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S1750728AbWEKTXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 15:23:16 -0400
Message-ID: <44638F21.7020201@dunaweb.hu>
Date: Thu, 11 May 2006 21:23:13 +0200
From: Zoltan Boszormenyi <zboszor@dunaweb.hu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in au8830 driver on x86-64
References: <446271C6.9050509@dunaweb.hu> <p73d5ek76k7.fsf@bragg.suse.de>
In-Reply-To: <p73d5ek76k7.fsf@bragg.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andi Kleen írta:
> Zoltan Boszormenyi <zboszor@dunaweb.hu> writes:
>   
>> I couldn't seek further, I put the card away for now. :-)
>>     
>
> First thing I would do is to fix all the compile warnings.
>
> -Andi
>
>   

What warnings are you talking about?

...
  LD [M]  sound/pci/ali5451/snd-ali5451.o
  LD      sound/pci/au88x0/built-in.o
  CC [M]  sound/pci/au88x0/au8810.o
  CC [M]  sound/pci/au88x0/au8820.o
  CC [M]  sound/pci/au88x0/au8830.o
  LD [M]  sound/pci/au88x0/snd-au8810.o
  LD [M]  sound/pci/au88x0/snd-au8820.o
  LD [M]  sound/pci/au88x0/snd-au8830.o
  LD      sound/pci/ca0106/built-in.o
  CC [M]  sound/pci/ca0106/ca0106_main.o
...

Should I do an 'export CFLAGS="-Wall"' before make?

Best regards,
Zoltán Böszörményi

