Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132949AbRDJHcR>; Tue, 10 Apr 2001 03:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132950AbRDJHcH>; Tue, 10 Apr 2001 03:32:07 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:12184 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S132949AbRDJHcD> convert rfc822-to-8bit; Tue, 10 Apr 2001 03:32:03 -0400
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: mbs@mc.com (Mark Salisbury), jdike@karaya.com (Jeff Dike),
        linux-kernel@vger.kernel.org
Message-ID: <C1256A2A.00292B96.00@d12mta07.de.ibm.com>
Date: Tue, 10 Apr 2001 09:29:57 +0200
Subject: Re: No 100 HZ timer !
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>Its worth doing even on the ancient x86 boards with the PIT. It does
require
>some driver changes since
>
>
>    while(time_before(jiffies, we_explode))
>         poll_things();
>
>no longer works
On S/390 we have a big advantage here. Driver code of this kind does not
exist.
That makes it a lot easier for us compared to other architectures. As I
said in
the original posting, the patch I have is working fine for S/390.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


