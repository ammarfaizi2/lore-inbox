Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVKGTCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVKGTCl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVKGTCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:02:41 -0500
Received: from smtp3.nextra.sk ([195.168.1.142]:48652 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S964944AbVKGTCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:02:40 -0500
Message-ID: <436FA4CB.6020406@rainbow-software.org>
Date: Mon, 07 Nov 2005 20:02:35 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Zachary Amsden <zach@vmware.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14: CR4 not needed to be inspected on the 486 anymore?
References: <Pine.LNX.4.55.0511031600010.24109@blysk.ds.pg.gda.pl> <436A3C10.9050302@vmware.com> <Pine.LNX.4.55.0511031639310.24109@blysk.ds.pg.gda.pl> <436AA1FD.3010401@vmware.com> <p73fyqb2dtx.fsf@verdi.suse.de> <Pine.LNX.4.55.0511070931560.28165@blysk.ds.pg.gda.pl> <436F7673.5040309@vmware.com> <Pine.LNX.4.55.0511071632110.28165@blysk.ds.pg.gda.pl> <436F8601.4070201@vmware.com> <Pine.LNX.4.61.0511071157590.27658@chaos.analogic.com> <436F8FAE.90805@vmware.com> <Pine.LNX.4.61.0511071313330.27911@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0511071313330.27911@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
>>No, you won't.  #UD and #GP will not (I hesitate to say never, but other
>>than a processor bug, I believe that is correct) reset the processor.
>>And CR4 is not "undocumented", even on 486.
>>
> 
> 
> Yes it is. The i486 Programmer's reference manual documents only
> to CR3.

The manual might be older than the newer 486 CPUs.
And don't forget that not every 486 is Intel. There are at least Cyrix, 
AMD and UMC with interesting Am5x86-P75 and Cx5x86 too.

-- 
Ondrej Zary
