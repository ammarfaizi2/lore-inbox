Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132622AbRDKQZA>; Wed, 11 Apr 2001 12:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132623AbRDKQYv>; Wed, 11 Apr 2001 12:24:51 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:777 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S132622AbRDKQYk>;
	Wed, 11 Apr 2001 12:24:40 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: info <5740@mail.ru>
Date: Wed, 11 Apr 2001 18:23:45 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.4.3 compile error No 3
CC: linux-kernel@vger.kernel.org, John Jasen <jjasen@datafoundation.com>
X-mailer: Pegasus Mail v3.40
Message-ID: <4AC3B9077C6@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Apr 01 at 20:15, info wrote:
> 
> By the way, I thung that it is a good idea - to modify
> xconfig/meniconfig script  in manner to make disable ipx if sysctl
> setted off - like in many other cross-dependance options. 

Without sysctl you cannot disable Netbios propagation packet routing.
And no machine with enabled Netbios routing passes our 'you must not
participate in broadcast storms' test if it has enabled more than
one IPX frame on each interface. So you'll get disconnected from our 
university net.
                                    Petr Vandrovec
                                    vandrove@vc.cvut.cz
                                    
