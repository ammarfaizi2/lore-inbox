Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbUKXAJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbUKXAJm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbUKWRe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:34:58 -0500
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:14230 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S261367AbUKWQUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:20:11 -0500
Message-ID: <41A3634D.6050108@rnl.ist.utl.pt>
Date: Tue, 23 Nov 2004 16:20:29 +0000
From: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041107)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: linux-os@analogic.com
Subject: Re: Running Ethernet without ARP
References: <20041123140025.GA32447@beton.cybernet.src> <Pine.LNX.4.61.0411230937140.4513@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0411230937140.4513@chaos.analogic.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> On Tue, 23 Nov 2004, Karel Kulhavy wrote:
> 
>> Hello
>>
>> man netdevice says:
>> "IFF_NOARP    No arp protocol, L2 deswtination address not set".
>> Is it possible to run ptp Ethernet link between two Linux routers this
>> way? I would like to run the link with two constraints:
>> 1) no ARP protocol used
>> 2) The link should continue to work even if root access to one 
>> computer is
>> inaccessible and the NIC in the other one is replaced without changing
>> it's MAC (for example because it doesn't support MAC change)
>>
>> Cl<
> 
> 
> ARP means address resolution protocol. That's how one machine
> learns about the MAC (Hardware) address of another so it can
> communicate with it. Without ARP, you need to send / receive
> broadcast packets (Like M$ Netboius). This means that everything
> is received by everyone on the LAN and needs to be dumped on
> the floor by everybody except the intended target.

or somehow a static table can be built.
not sure what the point would be, but I cannot see anything that would make it impossible.

regards,
pedro venda.

-- 

Pedro João Lopes Venda
email: pjvenda@rnl.ist.utl.pt
http://maxwell.rnl.ist.utl.pt

Equipa de Administração de Sistemas
Rede das Novas Licenciaturas (RNL)
Instituto Superior Técnico
http://www.rnl.ist.utl.pt
http://mega.ist.utl.pt
