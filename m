Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbUKQWF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbUKQWF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbUKQWFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:05:08 -0500
Received: from advect.atmos.washington.edu ([128.95.89.50]:11720 "EHLO
	advect.atmos.washington.edu") by vger.kernel.org with ESMTP
	id S262566AbUKQVPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:15:16 -0500
Message-ID: <419BBF57.3040808@atmos.washington.edu>
Date: Wed, 17 Nov 2004 13:15:03 -0800
From: Harry Edmon <harry@atmos.washington.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Josefsson <gandalf@wlug.westbo.se>
CC: Con Kolivas <kernel@kolivas.org>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Network slowdown from 2.6.7 to 2.6.9
References: <419A9151.2000508@atmos.washington.edu>	 <20041116163257.0e63031d@zqx3.pdx.osdl.net>	 <cone.1100651833.776334.15267.502@pc.kolivas.org>	 <419BA5C4.4020503@atmos.washington.edu> <1100722571.20185.9.camel@tux.rsn.bth.se>
In-Reply-To: <1100722571.20185.9.camel@tux.rsn.bth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -12.766 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, it is not loaded.  Here is the list of loaded modules under 2.6.9:

Module                  Size  Used by
nfs                   229732  5
af_packet              23432  2
autofs4                20356  2
capability              5640  0
commoncap               8192  1 capability
ipv6                  260224  98
eepro100               30860  0
uhci_hcd               32784  0
usbcore               116068  3 uhci_hcd
e100                   34816  0
mii                     6016  2 eepro100,e100
nfsd                  227104  65
exportfs                7168  1 nfsd
lockd                  69576  3 nfs,nfsd
sunrpc                151780  19 nfs,nfsd,lockd
sd_mod                 18816  2
ide_cd                 42912  0
cdrom                  40860  1 ide_cd
3w_xxxx                41764  1
scsi_mod              124100  2 sd_mod,3w_xxxx
rtc                    13768  0
unix                   29332  30


Martin Josefsson wrote:

>On Wed, 2004-11-17 at 20:25, Harry Edmon wrote:
>  
>
>>Tried your suggestion - no improvement.
>>    
>>
>
>I saw fron your .config that you have ip_conntrack as module, is it
>loaded? The TCP part of ip_conntrack got a pretty huge makeover in 2.6.9
>which also added more complexity to the code... and now it verifies the
>checksums of all TCP packets.
>
>  
>

