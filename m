Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292935AbSBQLdX>; Sun, 17 Feb 2002 06:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292936AbSBQLdD>; Sun, 17 Feb 2002 06:33:03 -0500
Received: from relay-2m.club-internet.fr ([195.36.216.171]:28397 "HELO
	relay-2m.club-internet.fr") by vger.kernel.org with SMTP
	id <S292935AbSBQLc5>; Sun, 17 Feb 2002 06:32:57 -0500
Message-ID: <3C6F946F.6030207@freesurf.fr>
Date: Sun, 17 Feb 2002 12:30:55 +0100
From: Kilobug <kilobug@freesurf.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020215
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: netfilter@lists.samba.org
Cc: netfilter-devel@lists.samba.org, lkm <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.18-pre9-mjc2 breaks some netfilter modules
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	I've upgraded from 2.4.18-pre3-mjc3 to 2.4.18-pre9-mjc2 and the following 
netfilter modules are now broken:

depmod: *** Unresolved symbols in 
/lib/modules/2.4.18-pre9-mjc2-kb1/kernel/net/ipv4/netfilter/ipt_owner.o
depmod:         pidhash_bits
depmod:         pidhash_size
depmod: *** Unresolved symbols in 
/lib/modules/2.4.18-pre9-mjc2-kb1/kernel/net/ipv4/netfilter/ipt_time.o
depmod:         get_fast_time
make: *** [_modinst_post] Erreur 1

I'm using iptables 1.2.5 (debian Sid package)

Hoping this can help you,

-- 
** Gael Le Mignot "Kilobug", Ing3 EPITA - http://kilobug.free.fr **
Home Mail   : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

"Software is like sex it's better when it's free.", Linus Torvalds

