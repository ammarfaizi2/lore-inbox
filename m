Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263159AbSJBOei>; Wed, 2 Oct 2002 10:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263160AbSJBOei>; Wed, 2 Oct 2002 10:34:38 -0400
Received: from host187.south.iit.edu ([216.47.130.187]:12673 "EHLO
	host187.south.iit.edu") by vger.kernel.org with ESMTP
	id <S263159AbSJBOei>; Wed, 2 Oct 2002 10:34:38 -0400
Message-ID: <3D9B0500.6010908@host187.south.iit.edu>
Date: Wed, 02 Oct 2002 09:38:56 -0500
From: Stephen Marz <smarz@host187.south.iit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Netfilter: Unresolved Symbols
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been getting this error when running make modules_install since 
kernel 2.5.38:

Installing modules in /lib/modules/2.5.40/kernel/lib
make[1]: Leaving directory `/rad000/users/tspace/smarz/linux-2.5.40/lib'
make[1]: Entering directory 
`/rad000/users/tspace/smarz/linux-2.5.40/arch/i386/lib'
make[1]: Leaving directory 
`/rad000/users/tspace/smarz/linux-2.5.40/arch/i386/lib'
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.40; fi
depmod: *** Unresolved symbols in 
/lib/modules/2.5.40/kernel/net/ipv4/netfilter/ipt_owner.o
depmod:     next_thread
depmod:     find_task_by_pid
make: *** [_modinst_post] Error 1



