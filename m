Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132841AbRDDPiL>; Wed, 4 Apr 2001 11:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132843AbRDDPiB>; Wed, 4 Apr 2001 11:38:01 -0400
Received: from staffnet.com ([207.226.80.14]:35345 "EHLO staffnet.com")
	by vger.kernel.org with ESMTP id <S132841AbRDDPhv>;
	Wed, 4 Apr 2001 11:37:51 -0400
Message-ID: <3ACB3FA1.D1525B91@staffnet.com>
Date: Wed, 04 Apr 2001 11:37:05 -0400
From: Wade Hampton <whampton@staffnet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.2.19 toshiba option broken
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my toshiba laptop, I am trying to use 2.2.19.
However, building it with the Toshiba Laptop option
set to Y or M results in errors.  The errors 
from setting it to M are:

toshiba.c:81: toshiba.h: No such file or directory
toshiba.c:156: parse error before `*'
...

The fix is to edit drivers/char/toshiba.c
and change 

	#include "toshiba.h"

to 
	#include"linux/toshiba.h"

Cheers,
-- 
W. Wade, Hampton  <whampton@staffnet.com>  
If Microsoft Built Cars:  Every time they repainted the 
lines on the road, you'd have to buy a new car.
Occasionally your car would just die for no reason, and 
you'd have to restart it, but you'd just accept this.
