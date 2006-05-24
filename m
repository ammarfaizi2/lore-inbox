Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbWEXHRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbWEXHRL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 03:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWEXHRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 03:17:11 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:9107 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932640AbWEXHRK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 03:17:10 -0400
Message-ID: <447407BE.80205@aitel.hist.no>
Date: Wed, 24 May 2006 09:14:06 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Compact Flash Serial ATA patch
References: <1148379397.1182.4.camel@gt-alphapbx2> <1148410590.25255.115.camel@localhost.localdomain> <20060523204746.GD9829@dantooine>
In-Reply-To: <20060523204746.GD9829@dantooine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

markus reichelt wrote:
> * Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
>   
>> On Maw, 2006-05-23 at 04:16 -0600, Russell McConnachie wrote:
>>     
>>> I am not exactly a programmer, I'm sure this can be written much
>>> better but for anyone who may run into a similar problem with
>>> compact flash.
>>>       
>> Some CF adapters do not include all the neccessary pins for DMA
>> because they were designed to be cheap before the idea of CF using
>> DMA seemed realistic.
>>     
>
> Some CF adapters I've seen included all necessary pins but the pin
> connections for DMA were missing. Someone at a slackware mailing list
> was having the same problem, and if I recall correctly (better check
> specs though) it can be fixed quite easily:
>
> CF pin 44: disconnect from +V, connect to IDE pin 29.
> CF pin 43: connect to IDE pin 21.
>
> Typical transfer rates increased to about 10-12 MB/s
>   
No more than that?  I have a CF card on parallel IDE,
hdparm can read 20MB/s from it with the 4GB 100xKingston
card I use to boot from.  Of course this card was bought
precisely for its speed (and size).

Helge Hafting

