Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129812AbQKHWce>; Wed, 8 Nov 2000 17:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbQKHWcY>; Wed, 8 Nov 2000 17:32:24 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:7674 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129812AbQKHWcQ>; Wed, 8 Nov 2000 17:32:16 -0500
Date: Wed, 08 Nov 2000 16:32:13 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: `smp_num_cpus' redefined
X-Mailer: The Polarbar Mailer (pbm 1.17b)
Message-Id: <20001108223222Z129812-31179+2060@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling under 2.4, I get this:

/usr/include/linux/smp.h:80: warning: `smp_num_cpus' redefined
/usr/include/linux/modules/i386_ksyms.ver:82: warning: this is the location of
the previous definition
/usr/include/linux/smp.h:87: warning: `smp_call_function' redefined
/usr/include/linux/modules/i386_ksyms.ver:98: warning: this is the location of
the previous definition
/usr/include/linux/smp.h:88: warning: `cpu_online_map' redefined
/usr/include/linux/modules/i386_ksyms.ver:84: warning: this is the location of
the previous definition

Where does i386_ksyms.ver come from?



-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
