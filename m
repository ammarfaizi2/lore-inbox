Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272519AbRH3WOH>; Thu, 30 Aug 2001 18:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272522AbRH3WN6>; Thu, 30 Aug 2001 18:13:58 -0400
Received: from t2.redhat.com ([199.183.24.243]:19191 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S272519AbRH3WNp>; Thu, 30 Aug 2001 18:13:45 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200108302156.f7ULujo24456@oboe.it.uc3m.es> 
In-Reply-To: <200108302156.f7ULujo24456@oboe.it.uc3m.es> 
To: ptb@it.uc3m.es
Cc: "Herbert Rosmanith" <herp@wildsau.idv-edu.uni-linz.ac.at>,
        linux-kernel@vger.kernel.org, dhowells@cambridge.redhat.com
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 30 Aug 2001 23:13:31 +0100
Message-ID: <11888.999209611@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ptb@it.uc3m.es said:
>  You got me curious enough to try it.  It compiles and links fine with
> -O1 and higher under

>        gcc version 2.95.2 20000220 (Debian GNU/Linux)
>        gcc version 2.8.1
>        gcc version 2.7.2.3 

Oh well, then it _must_ be safe then - gcc has never changed unspecified 
behaviour on us before, has it?

The gcc engineer who took one look at the __buggy_udelay cruft, raised his
eyebrows, swore and wandered off muttering must just have been having a bad
day or something.

--
dwmw2


