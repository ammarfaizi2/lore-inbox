Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129939AbQLQSiF>; Sun, 17 Dec 2000 13:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130325AbQLQShz>; Sun, 17 Dec 2000 13:37:55 -0500
Received: from ms1.hinet.net ([168.95.4.10]:52726 "EHLO ms1.hinet.net")
	by vger.kernel.org with ESMTP id <S129939AbQLQShw>;
	Sun, 17 Dec 2000 13:37:52 -0500
Message-ID: <3A3D00A7.87F6051F@teatime.com.tw>
Date: Mon, 18 Dec 2000 02:06:31 +0800
From: Tommy Wu <tommy@teatime.com.tw>
Reply-To: tommy@teatime.com.tw
Organization: TeaTime Development
X-Mailer: Mozilla 4.76 [zh] (Windows NT 5.0; U)
X-Accept-Language: en,zh,zh-TW,zh-CN
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel panic for nfsd access for test12
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Does anyone use nfsd on kernel 2.4.0-test12 ?

  Usually, I backup my linux box via another machine use nfs to mount it, then run
  afio to backup file to mo. It is work very fine through kernel 2.4.0-test7 to test11.

  But this week, I change my linux box's kernel to 2.4.0-test12, I found when I use
  another linux box (kernel 2.2.18pre21) to mount the directory in the linux server
  running kernel 2.4.0-test12, it can be mounted, but if I do any file access, the
  server will show kernel panic screen.... and there is no any log write down to file.
  All system will be halt, just can be power down. (SysRq don't work)

  I change the kernel back to 2.4.0-test11, everything is ok. So, I think it should be
  a bug in 2.4.0-test12. (I use the same .config to build both kernel, nfsd is make as
  a module)

  Because I can't see all of the kernel trace dump screen, so I can't give any ksymoops
  for that...

-- 

    Tommy Wu
    mailto:tommy@teatime.com.tw
    http://www.teatime.com.tw/~tommy
    ICQ: 22766091
    Mobile Phone: +886 936 909490
    TeaTime BBS +886 2 3151964 24Hrs V.Everything

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
