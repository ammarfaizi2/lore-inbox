Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132658AbRDKRBL>; Wed, 11 Apr 2001 13:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132659AbRDKRBB>; Wed, 11 Apr 2001 13:01:01 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:24585 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S132655AbRDKRAp> convert rfc822-to-8bit;
	Wed, 11 Apr 2001 13:00:45 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: info <5740@mail.ru>
Date: Wed, 11 Apr 2001 18:59:58 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-2
Content-transfer-encoding: 8BIT
Subject: Re: 2.4.3 compile error No 3
CC: linux-kernel@vger.kernel.org, John Jasen <jjasen@datafoundation.com>
X-mailer: Pegasus Mail v3.40
Message-ID: <4ACD67C0A55@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Apr 01 at 20:34, info wrote:
>  ïÎ, 12 ßðÏ 2001, Î Ë¤¤-Þ++++ +- ï+-Ò "Re: 2.4.3 compile error No 3", Petr Vandrovec +-ð+Ë-|:
> > On 11 Apr 01 at 20:15, info wrote:

> > Without sysctl you cannot disable Netbios propagation packet routing.
> > And no machine with enabled Netbios routing passes our 'you must not
> > participate in broadcast storms' test if it has enabled more than
> > one IPX frame on each interface. So you'll get disconnected from our 
> > university net.
> 
> My user's mind was: if sysctl is needed for ipx, then:
> 1-st variant -  to modify config script in such manner that sysctl
> turned on automatically (maybe as other needable functions, if they
> are) if ipx selected. 
> 2-nd variant - to modify it in such manner that you can't select ipx
> before you select sysctl 

You can use IPX without this sysctl in small networks. But in large
network sooner or later net admin comes to you with baseball bat.

Patch I sent to you fixes compilation troubles.
                                                        Petr Vandrovec
                                                        
