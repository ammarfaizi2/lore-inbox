Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265984AbUAKVDP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 16:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265985AbUAKVDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 16:03:15 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:13574 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S265984AbUAKVDN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 16:03:13 -0500
Message-ID: <4001BA10.5080803@mistur.org>
Date: Sun, 11 Jan 2004 22:03:12 +0100
From: yoann <informatique@mistur.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: fr, fr-fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1: data corrupton when recieving files > 1GB over network
References: <5.1.0.14.2.20040111161640.014ad6c0@localhost>	 <btsaum$g7f$1@sea.gmane.org> <1073854512.4967.18.camel@nidelv.trondhjem.org>
In-Reply-To: <1073854512.4967.18.camel@nidelv.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>same file : /mnt/multimedia/iso
>>
>>- mistur local (ext3) 2.4.18-1-686 :
>>   ca679b3b8e28be00b98b007611384958  /mnt/multimedia/iso/woody-cd1.iso
>>
>>- vaka remote (nfs) 2.4.18-bf2.4 :
>>   ea34f974bdcfb2a678a97afb1fb4077d  /mnt/multimedia/iso/woody-cd1.iso
>>
>>- vaka remote (nfs) 2.6.1-mm2 :
>>   ca679b3b8e28be00b98b007611384958  /mnt/multimedia/iso/woody-cd1.iso
>>   2798b3e2b97ca8082049c9207c291ebb  /mnt/multimedia/iso/woody-cd1.iso
> 
> Have you tried running memtest86 on these machines?

I will... but I've not problem and using a lot the 384Mo of RAM

> Also, is all this being done using the same 2.4.18-1 server on 'mistur',
> or are you also using a server on 'vaka'? 

unsig the same 2.4.18 on mistur and vaka stays nfs client

> If the former, have you tried changing servers? (BTW: is this the kernel
> server, or are you using the userland nfs-server daemon).

kernelland

I haven't try in userland

> Cheers,
>   Trond

Yoann

