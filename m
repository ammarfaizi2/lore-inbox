Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVIGNZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVIGNZu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 09:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVIGNZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 09:25:50 -0400
Received: from venezia.uab.es ([158.109.168.132]:24933 "EHLO venezia.uab.es")
	by vger.kernel.org with ESMTP id S1751209AbVIGNZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 09:25:49 -0400
Date: Wed, 07 Sep 2005 15:26:24 +0200
From: =?UTF-8?B?TcOgcml1cyBNb250w7Nu?= <Marius.Monton@uab.es>
Subject: Re: 'virtual HW' into kernel (SystemC)
In-reply-to: <431ED7F2.5030200@pobox.com>
To: linux-kernel@vger.kernel.org
Message-id: <431EEA80.3080900@uab.es>
Organization: Cephis-UAB
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_EWQxJNnyg5pQHDRF4een/A)"
X-Accept-Language: ca, es
X-Enigmail-Version: 0.92.0.0
References: <431EC16B.2040604@uab.es> <431ED1B9.7040407@pobox.com>
 <431ED6DC.9040503@lifl.fr> <431ED7F2.5030200@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-OriginalArrivalTime: 07 Sep 2005 13:26:34.0490 (UTC)
 FILETIME=[C45B65A0:01C5B3AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_EWQxJNnyg5pQHDRF4een/A)
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8BIT

All suggestions are good, but from my point of view, both solutions
(entire simulated system, or using an emulator) could be too slow and
too much artificial, so in translation to 'real world' can be a lot of
problems.

I think our approach is the most real environment for our SystemC module.

We will try to implement in this way, so any hints here will be appreciated.
Thanks

Màrius



Jeff Garzik wrote:

> Eric Piel wrote:
>
>> 09/07/2005 01:40 PM, Jeff Garzik wrote/a écrit:
>>
>>> No need for a set of tools.  As long as your SystemC simulator
>>> simulates an entire platform -- CPU, DRAM, etc. -- then you can boot
>>> Linux on the simulated platform.
>>>
>>> If you can boot Linux on the simulated platform, then you can easily
>>> develop a Linux driver long before real HW is available.
>>
>>
>>
>> No, this approach is not feasible because it would be require to
>> describe the entire computer in SystemC:
>
>
> Correct.
>
>> it's extremly complex to do
>
>
> Not if you can reuse pre-existing parts from http://www.opencores.org/
> and similar places.
>
>
>> the simulation will be very slow.
>
>
> Depends on your simulator ;-)
>
>
>>  From what I understand Màrius tries to only simulate one component
>> (like a PCI card). As suggested Muli, a plugin to something like
>> quemu sounds like a good idea?
>
>
> A plugin to qemu or Bochs should work, in theory.  In practice,
> neither are great for PCI MMIO or PCI DMA.
>
>     Jeff
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
Màrius Montón i Macián   marius.monton@uab.es
<mailto:marius.monton@uab.es>  http://microelec.uab.es/~marius
<http://microelec.uab.es/%7Emarius>
Hardware Engineer
CEPHIS
Centre de Prototips i Solucions Hardware-Software
Dep. Microelectrònica i Sistemes Electrònics
ETSE - Universitat Autònoma de Barcelona (UAB) 	Phone: +34 935 813 534
Fax: +34 935 813 033
QC2088. ETSE. Campus UAB.
080193 Bellaterra



--Boundary_(ID_EWQxJNnyg5pQHDRF4een/A)
Content-type: text/x-vcard; charset=utf-8; name=marius.monton.vcf
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=marius.monton.vcf

begin:vcard
fn;quoted-printable:M=C3=A0rius Mont=C3=B3n
n;quoted-printable;quoted-printable:Mont=C3=B3n;M=C3=A0rius
org;quoted-printable:UAB;Departament de Microelectr=C3=B2nica i Sistemes Electr=C3=B2nics
adr:Campus de la UAB;;QC-2088 ETSE;Bellaterra;Barcelona;08193;SPAIN
email;internet:marius.monton@uab.es
tel;work:+34935813534
x-mozilla-html:TRUE
url:http://cephis.uab.es
version:2.1
end:vcard


--Boundary_(ID_EWQxJNnyg5pQHDRF4een/A)--
