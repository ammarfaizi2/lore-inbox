Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285482AbRLYL5c>; Tue, 25 Dec 2001 06:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285484AbRLYL5X>; Tue, 25 Dec 2001 06:57:23 -0500
Received: from mail1.arcor-ip.de ([145.253.2.10]:32718 "EHLO mail1.arcor-ip.de")
	by vger.kernel.org with ESMTP id <S285482AbRLYL5O>;
	Tue, 25 Dec 2001 06:57:14 -0500
Message-ID: <3C28698A.9020606@arcormail.de>
Date: Tue, 25 Dec 2001 12:56:58 +0100
From: Hartmut Holz <hartmut.holz@arcormail.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: "=?ISO-8859-1?Q?Fr=E9d=E9ric?= L. W. Meunier" <0@pervalidus.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: EMU10K1: IRQ 10 ?
In-Reply-To: <20011225034725.GA148@pervalidus> <200112250401.fBP41E025476@barn.psychohorse.com> <20011225043232.GC148@pervalidus> <200112250440.fBP4eu025586@barn.psychohorse.com> <20011225054059.GD148@pervalidus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FrÈdÈric L. W. Meunier wrote:

> On Mon, Dec 24, 2001 at 08:41:19PM -0800, Matthew Johnson wrote:
> 
>>On Monday 24 December 2001 08:32 pm, you wrote:
>>
> 
>>>>I'd cheat and use sndconfig ot yast2 or whatever else.
>>>>Failing that I can give you some idea via my modules.conf,
>>>>but I use SuSE, whcih in turn uses Alsa.
>>>>
>>>OK, so I'll try ALSA.
>>>
>>>My modules.conf just includes 'alias sound emu10k1'.
>>>
> 
> Dec 25 03:13:38 pervalidus kernel: PCI: Found IRQ 10 for device 00:0b.0
> 
> OK, ALSA worked, while OSS from the kernel didn't. I don't
> know why.
> 
> I still have a problem. Sound is very distorted with a lot of
> noise when I do a 'cat /home/ftp/pub/sound/ra/english.au >
> /dev/audio' . Maybe my speakers are broken ? I never used
> them before. Time to do more testing. Yes, I know nothing
> about sound.
> 


Same for me. But if you use a real application like plaympeg or
sox hi.au -t ossdsp /dev/dsp it works fine. I'm using emu10k1
from http://opensource.creative.com





-- 
Hartmut Holz                                EMail: H.Holz@hamburg.de
Kieler Straﬂe 231			    Phone: +49 4085080014	
22525 Hamburg
Germany

