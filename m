Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293204AbSCZIwf>; Tue, 26 Mar 2002 03:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293242AbSCZIwY>; Tue, 26 Mar 2002 03:52:24 -0500
Received: from mario.gams.at ([194.42.96.10]:14200 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S293204AbSCZIwK>;
	Tue, 26 Mar 2002 03:52:10 -0500
Message-Id: <200203260852.JAA05393@merlin.gams.co.at>
Content-Type: text/plain; charset=US-ASCII
From: Axel Kittenberger <Axel.Kittenberger@maxxio.com>
Organization: Maxxio Technologies
To: David Brown <dave@codewhore.org>
Subject: Re: Patch, forward release() return values to the close() call
Date: Tue, 26 Mar 2002 09:52:08 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203210747.IAA25949@merlin.gams.co.at> <200203250950.KAA23657@merlin.gams.co.at> <20020325083350.A16464@codewhore.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Agreed, but the question is which approach to use. :) Declaring it as void
> sounds like it may involve a lot of driver fixup work.

For the first way of doing I already provided a patch, which started this 
thread.  (returning the release() value proparly to the close())

However if I get a word from the applicate maintaners (linus or viro) that  a 
patch declaring release() with void return type will be accepted for 2.5.x, I 
would volunteer for providing it. Should not be that much of a work, once you 
concentrate on it. However I'm not doing it for the birds :o)  (without 
consultation first). 

Personlaly I'm unsure which of both decisions would be better, but am 
unsatisfied with the way it's currently.
