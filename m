Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270669AbTG0Eqb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 00:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270671AbTG0Eqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 00:46:31 -0400
Received: from mail1.cc.huji.ac.il ([132.64.1.17]:52679 "EHLO
	mail1.cc.huji.ac.il") by vger.kernel.org with ESMTP id S270669AbTG0Eq3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 00:46:29 -0400
Message-ID: <3F23517B.9030407@mscc.huji.ac.il>
Date: Sun, 27 Jul 2003 07:13:47 +0300
From: Voicu Liviu <pacman@mscc.huji.ac.il>
Organization: Hebrew University of Jerusalem
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030713
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: alexander.riesen@synopsys.COM, linux-kernel@vger.kernel.org
Subject: Re: IPX support to kernel 2.6
References: <3F1FAE0C.4090608@mscc.huji.ac.il> <20030724135347.GK13611@Synopsys.COM> <3F1FDB97.7060907@mscc.huji.ac.il> <20030726172048.GB1189@conectiva.com.br>
In-Reply-To: <20030726172048.GB1189@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.2(snapshot 20021217) (pluto.mscc.huji.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 24, 2003 at 04:13:59PM +0300, Voicu Liviu escreveu:
> 
>>Alex Riesen wrote:
>>
>>>Voicu Liviu, Thu, Jul 24, 2003 11:59:40 +0200:
>>>
>>>>Problem:
>>>>
>>>>Hi guys, I wanted to add IPX support to kernel 2.6 in order to mount 
>>>>novell volumes but it seems not tu exist!
>>>
>>>It is renamed:
>>>ANSI/IEEE 802.2 - aka LLC (IPX, Appletalk, Token Ring)
>>>under Networking support/Networking options.
>>>
>>
>>Wow, I appreciate your help
> 
> 
> It was not renamed, it just requires that LLC be selected first, then one has
> to select IPX as before.
> 
> I plan to make the LLC1 part, that is all that is needed for IPX, Appletalk and
> Token Ring to be separated from the big llc module, and making those depending
> only on LLC1 to be top level in the config, triggering the selection of LLC1
> automatically, this will help as well on not having to have LLC2 when all one
> wants is IPX, Appletalk or Token Ring.
> 
> - Arnaldo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Thank you very much for your response,

-- 
Voicu Liviu
Rothberg International School
Computation center, Mount Scopus
Hebrew University of Jerusalem
Tel: 972(2)-5881253
E-mail: pacman@mscc.huji.ac.il

System Operating: Linux Gentoo1.4 ( www.gentoo.org )

Click here to see my GPG signature:
	http://search.keyserver.net:11371/pks/lookup?template=netensearch%2Cnetennomatch%2Cnetenerror&search=pacman%40mscc.huji.ac.il&op=vindex&fingerprint=on&submit=Get+List


