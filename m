Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268342AbRH0HeU>; Mon, 27 Aug 2001 03:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268129AbRH0HeA>; Mon, 27 Aug 2001 03:34:00 -0400
Received: from urc1.cc.kuleuven.ac.be ([134.58.10.3]:21196 "EHLO
	urc1.cc.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id <S271658AbRH0Hdu>; Mon, 27 Aug 2001 03:33:50 -0400
Message-ID: <3B89F7EE.147DBF5B@pandora.be>
Date: Mon, 27 Aug 2001 09:34:06 +0200
From: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
Organization: MyHome
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: nl-BE, nl, en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: time question
In-Reply-To: <3B89F5D6.5813BF4D@pandora.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bart Vandewoestyne wrote:
> 
> I'm trying to port the DOS driver for a data aquisition card to linux
> (http::/mc303.ulyssis.org).  It is my first linux driver writing
> attempt. Somewhere in the code i have the following lines of DOS-code
> that do some busy waiting:
> 
> _bios_timeofday(_TIME_GETCLOCK,&tb); l = tb;
>   while(l-tb < 2) _bios_timeofday(_TIME_GETCLOCK,&l);
> 
> What is the best linux equivalent for this?

Sorry, the URL should be: http://mc303.ulyssis.org/heim/

Greetings,
Bart

-- 
Ing. Bart Vandewoestyne			 Bart.Vandewoestyne@pandora.be
Hugo Verrieststraat 48			       GSM: +32 (0)478 397 697
B-8550 Zwevegem			 http://users.pandora.be/vandewoestyne
----------------------------------------------------------------------
"Any fool can know, the point is to understand." - Albert Einstein
