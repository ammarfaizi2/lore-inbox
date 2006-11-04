Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965711AbWKDVWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965711AbWKDVWi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 16:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965710AbWKDVWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 16:22:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:39655 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965711AbWKDVWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 16:22:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=ke1InHGmlCMS3eLCY5ASFOrTUs50fB79yenMOaG/RH3+69LvouEPLqgJG5imHUubvl+shX2eeR1R3BTM3ZP6hSX2tGBuVbHwYg9Us5aGeqgHjrku2FqkR2mkDgT9JXgH3eR51ls3zdAnkpq2VzNVvq621ft7427wylkkn1lSyjo=
Message-ID: <454D04B6.9010209@gmail.com>
Date: Sat, 04 Nov 2006 22:22:39 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Jesper Juhl <jesper.juhl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: removing drivers and ISA support? [Was: Char: correct pci_get_device
 changes]
References: <4540F79C.7070705@gmail.com> <20061026222525.GP27968@stusta.de> <9a8748490610261531s539b0861t621e95c785b53d7@mail.gmail.com> <45414641.6060709@gmail.com> <20061026235628.GT27968@stusta.de>
In-Reply-To: <20061026235628.GT27968@stusta.de>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Fri, Oct 27, 2006 at 01:35:06AM +0159, Jiri Slaby wrote:
>> Jesper Juhl wrote:
>>> On 27/10/06, Adrian Bunk <bunk@stusta.de> wrote:
>>>> On Thu, Oct 26, 2006 at 07:59:56PM +0200, Jiri Slaby wrote:
>>>>> ...
>>>>> And what about (E)ISA support. When converting to pci probing,
>>>> should be ISA bus
>>>>> support preserved (how much is ISA used in present)? -- it makes
>>>> code ugly and long.
>>>>
>>>> There seem to be still many running 486 machines - and only the last 486
>>>> boards also had PCI slots.
>>>>
>>>> While deprecating OSS drivers, I got emails from people still using some
>>>> of the ISA cards.
>> That might be a problem if the whole subsystem disappears, but if only ISA
>> support from some driver is pruned away, they are still able to use the old
>> driver by replacing the new one from some older kernel.
>> Then, we'll get nicer drivers in return.
> 
> - this doesn't work for people using distribution kernels
> - "by replacing the new one from some older kernel" doesn't sound
>   reasonable - 3 or 4 point releases later it will have become pretty
>   unlikely that the driver will still work unmodified
>   (if you disagree, please name one ISA driver where the 2.6.15 version
>    compiles without any modifications in 2.6.19-rc3)

Ok, thank all for the notes,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
