Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130668AbQLQTfR>; Sun, 17 Dec 2000 14:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130676AbQLQTfH>; Sun, 17 Dec 2000 14:35:07 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:59567 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130668AbQLQTew>; Sun, 17 Dec 2000 14:34:52 -0500
Message-ID: <3A3D0E0F.9B617E76@haque.net>
Date: Sun, 17 Dec 2000 14:03:43 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tommy@teatime.com.tw
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic for nfsd access for test12
In-Reply-To: <3A3D00A7.87F6051F@teatime.com.tw>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you use netfilter? It's a known bug if you do.

Tommy Wu wrote:
> 
>   Does anyone use nfsd on kernel 2.4.0-test12 ?
> 
>   Usually, I backup my linux box via another machine use nfs to mount it, then run
>   afio to backup file to mo. It is work very fine through kernel 2.4.0-test7 to test11.
> 
>   But this week, I change my linux box's kernel to 2.4.0-test12, I found when I use
>   another linux box (kernel 2.2.18pre21) to mount the directory in the linux server
>   running kernel 2.4.0-test12, it can be mounted, but if I do any file access, the
>   server will show kernel panic screen.... and there is no any log write down to file.
>   All system will be halt, just can be power down. (SysRq don't work)
> 
>   I change the kernel back to 2.4.0-test11, everything is ok. So, I think it should be
>   a bug in 2.4.0-test12. (I use the same .config to build both kernel, nfsd is make as
>   a module)
> 
>   Because I can't see all of the kernel trace dump screen, so I can't give any ksymoops
>   for that...

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
