Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277714AbRJRNv2>; Thu, 18 Oct 2001 09:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277716AbRJRNvT>; Thu, 18 Oct 2001 09:51:19 -0400
Received: from mail.spylog.com ([194.67.35.220]:43442 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S277714AbRJRNvC>;
	Thu, 18 Oct 2001 09:51:02 -0400
Date: Thu, 18 Oct 2001 17:47:06 +0400
From: "Oleg A. Yurlov" <kris@spylog.com>
X-Mailer: The Bat! (v1.53d)
Reply-To: "Oleg A. Yurlov" <kris@spylog.com>
Organization: SpyLOG Ltd.
X-Priority: 3 (Normal)
Message-ID: <111127919712.20011018174706@spylog.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re[2]: "3.5GB user address space" option.
In-Reply-To: <20011018110914.J12055@athlon.random>
In-Reply-To: <1981072193242.20011018021819@spylog.com>
 <9qlmcb$4h4$1@cesium.transmeta.com> <20011018110914.J12055@athlon.random>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Hi,

Thursday, October 18, 2001, 1:09:14 PM, you wrote:

AA> On Wed, Oct 17, 2001 at 09:38:35PM -0700, H. Peter Anvin wrote:
>> Followup to:  <1981072193242.20011018021819@spylog.com>
>> By author:    "Oleg A. Yurlov" <kris@spylog.com>
>> In newsgroup: linux.dev.kernel
>> >
>> > 
>> >         Hi, folks,
>> > 
>> >         How  I  can  use  3.5GB  in my apps ? I try malloc() and get error on 2G
>> > bounce... :-(
>> > 
>> >         Hardware - SMP server, 2Gb RAM, 8Gb swap, kernel 2.4.12aa1.
>> > 
>> 
>> Get a 64-bit CPU.  You're running into a fundamental limit of 32-bit
>> architectures.

AA> Actually 3.5G per-process is theoretically possible using a careful
AA> userspace as Rik suggested with -aa after enabling the proper
AA> compile time configuration option. So for apps that needs say 3G
AA> per-process it should work just fine. But of course for anything that
AA> needs more than that 64bit is the right way to go :)

        Thanks to all, problem solved :-) Now apps can use about 3.5G.

AA> Andrea
AA> -
AA> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
AA> the body of a message to majordomo@vger.kernel.org
AA> More majordomo info at  http://vger.kernel.org/majordomo-info.html
AA> Please read the FAQ at  http://www.tux.org/lkml/

--
Oleg A. Yurlov aka Kris Werewolf, SysAdmin      OAY100-RIPN
mailto:kris@spylog.com                          +7 095 332-03-88

