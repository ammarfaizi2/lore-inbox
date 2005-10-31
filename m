Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbVJaCkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbVJaCkT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 21:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVJaCkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 21:40:19 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:28894
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1751279AbVJaCkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 21:40:17 -0500
Message-ID: <4365920D.2080009@linuxwireless.org>
Date: Sun, 30 Oct 2005 20:39:57 -0700
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Marcel Holtmann <marcel@holtmann.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>	 <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade>	 <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade>	 <20051027211203.M33358@linuxwireless.org>	 <20051027220533.GA18773@redhat.com> <1130451071.5416.32.camel@blade>	 <20051027221253.GA25932@redhat.com> <1130451421.5416.35.camel@blade>	 <20051027221756.M55421@linuxwireless.org> <1130711165.32734.11.camel@localhost.localdomain>
In-Reply-To: <1130711165.32734.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Iau, 2005-10-27 at 18:20 -0400, Alejandro Bonilla wrote:
>  
>
>>Dude, again. This has nothing to do with the CPU. The arch IA32 is simply
>>_not_ made for 4GB, so, some motherboards manufacturers make a workaround like
>>    
>>
>
>Wrong IA-32 supports more than 4Gb in PAE 36bit physical 32bit virtual
>mode and has done since the Preventium Pro
>  
>

I guess you are right and wrong. The architecture has the limitation, 
the chipset as well and the OS. According to this document, it is the 
fault of the architecture as well as it requires to support addressing 
which is not available *stock*, only several other providers have added 
such "mapping" to get a better use of the memory.

http://www.intel.com/support/motherboards/server/sb/cs-010458.htm

I really don't want to argue on who knows more or less, just want to 
clarify the fact that IA32 will have this problem normally and that the 
chipsets that go with it also will make this noticeable.

If you don't believe me, contact the guys who built the Arch which I 
think are the ones that made the document?

.Alejandro
