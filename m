Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271877AbRHUWB2>; Tue, 21 Aug 2001 18:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271875AbRHUWBS>; Tue, 21 Aug 2001 18:01:18 -0400
Received: from mx6.port.ru ([194.67.57.16]:49668 "EHLO mx6.port.ru")
	by vger.kernel.org with ESMTP id <S271874AbRHUWBP>;
	Tue, 21 Aug 2001 18:01:15 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: [FAQ?] More ram=less performance (maximum cacheable RAM)
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.185]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E15ZJaT-000IzG-00@f3.mail.ru>
Date: Wed, 22 Aug 2001 02:01:30 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Patch and other info about non cacheable ram here :
> http://www.keryan.org/brad/slram/
>
> ciao,
> luca
    hi guys, the mentioned patch idea is a great one,
  i think, in the light of the situation with only
  512 Mb RAM cached with P2 (as mentioned above)...

  at least detection of uncached RAM is a must.

  should anybody port the patch to 2.4?
(there is still alot of people which use PI`s...),
and using uncached RAM as swap actually will increase
spped, rather than decrease it...

though, there is an other solution: 
allocate the tail as zones marked slow.

comments people?

---


cheers,


   Samium Gromoff
