Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292229AbSDIOm7>; Tue, 9 Apr 2002 10:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292231AbSDIOm6>; Tue, 9 Apr 2002 10:42:58 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:59017 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S292229AbSDIOm6>; Tue, 9 Apr 2002 10:42:58 -0400
Date: Tue, 09 Apr 2002 07:42:32 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
cc: Tony.P.Lee@nokia.com, kessler@us.ibm.com
Subject: Re: Event logging vs enhancing printk
Message-ID: <1979709341.1018338151@[10.10.2.3]>
In-Reply-To: <200204090821.g398LjX01722@Port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As I understand, Linus accepts new features only if they are improving
> kernel  in some vital area significantly (for example, Ingo's new
> scheduler).

I think that's more true of 2.4 than 2.5, but a change should indeed 
make some improvement to be accepted. What seems to be more vital
is that the cost:benefit ratio is advantageous ... much of the
discussions that Larry and I were having were oriented to keeping
the cost very low indeed ... if you didn't turn on event logging,
the cost would be pretty much 0 (just those macro unwraps).

> You'll need to show that "enhanced" printk/evlog is significant
> improvement  and is worth the trouble. That won't be easy.

Having worked in Customer service for a long time on high end
systems, I know that having accurate error logging is critical
to fast problem diagnosis. Look at the other extreme which people
like Microsoft drift towards ... I hate it when you get error
messages like "Error. Something is wrong somewhere".

If the open source methodology of "many eyes fix bugs" is to work
as well as possible, we need to help those eyes to see as clearly
as possible.

M.

