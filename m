Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129094AbRBLLWW>; Mon, 12 Feb 2001 06:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBLLWM>; Mon, 12 Feb 2001 06:22:12 -0500
Received: from blondy.mnz.si ([193.189.185.136]:6405 "EHLO blondy.mnz.si")
	by vger.kernel.org with ESMTP id <S129031AbRBLLWF>;
	Mon, 12 Feb 2001 06:22:05 -0500
Message-ID: <3A881D32.E9C4CC5A@kud-kontrabant.si>
Date: Mon, 12 Feb 2001 12:28:18 -0500
From: Janez Vrenjak <janez@kud-kontrabant.si>
Organization: KUD Kontrabant
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: sl, en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Kernel crash problem
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm getting these odd messages.
Result in that my box boes down. All files
that ware opened during or after the error
appears can not be closed and I get a lot of data lost.
I have redhat 7;kernel 2.4.1,pentium II.
What can I do against that??????

This is the error:
-----------------------------------------------------------------------------------------------

Feb  6 10:41:35 trol kernel: Unable to handle kernel paging request at
virtual address 001c9474
Feb  6 10:41:35 trol kernel:  printing eip:
Feb  6 10:41:35 trol kernel: c013d363
Feb  6 10:41:35 trol kernel: *pde = 00000000
Feb  6 10:41:35 trol kernel: Oops: 0000
Feb  6 10:41:35 trol kernel: CPU:    0
Feb  6 10:41:35 trol kernel: EIP:    0010:[path_walk+1203/2160]
Feb  6 10:41:35 trol kernel: EFLAGS: 00010206
Feb  6 10:41:35 trol kernel: eax: c14bfae0   ebx: 001c9474   ecx:
c0340000   edx: cc2a04a0
Feb  6 10:41:35 trol kernel: esi: c5669f9c   edi: c5668000   ebp:
c0848920   esp: c5669f34
Feb  6 10:41:35 trol kernel: ds: 0018   es: 0018   ss: 0018
Feb  6 10:41:35 trol kernel: Process kdeinit (pid: 29329,
stackpage=c5669000)
Feb  6 10:41:35 trol kernel: Stack: 000041ed 00000006 00000008 00000000
00000814 00001000 fffffff4 cbafe000
Feb  6 10:41:35 trol kernel:        cbafe005 00000002 000002ce 081940d8
00000000 cbafe000 c5669f9c bfffe5c0
Feb  6 10:41:35 trol kernel:        c013dada cbafe000 c5669f9c c5668000
08194010 bfffe868 c013a933 081940d8
Feb  6 10:41:35 trol kernel: Call Trace: [__user_walk+58/96]
[sys_lstat64+19/112] [system_call+51/64] [_stext+43/313]
Feb  6 10:41:35 trol kernel:
Feb  6 10:41:35 trol kernel: Code: 8b 03 85 c0 75 19 68 ed 00 00 00 68
00 f4 27 c0 68 d1 f3 27
Feb  6 11:12:20 trol kernel: apm: poll passed bad filp
------------------------------------------------------------------------------------------------

and one more:


Feb  7 09:02:03 trol kernel: Unable to handle kernel paging request at virtual address 08a35004
Feb  7 09:02:03 trol kernel:  printing eip:
Feb  7 09:02:03 trol kernel: c014513f
Feb  7 09:02:03 trol kernel: *pde = 00000000
Feb  7 09:02:03 trol kernel: Oops: 0000
Feb  7 09:02:03 trol kernel: CPU:    0
Feb  7 09:02:03 trol kernel: EIP:    0010:[__d_path+159/288]
Feb  7 09:02:03 trol kernel: EFLAGS: 00010207
Feb  7 09:02:03 trol kernel: eax: c14bfae0   ebx: ce294ffe   ecx: 00000000   edx: 00000000
Feb  7 09:02:03 trol kernel: esi: 00000000   edi: ce294fff   ebp: 08a34ff8   esp: ca5c1eb8
Feb  7 09:02:03 trol kernel: ds: 0018   es: 0018   ss: 0018
Feb  7 09:02:03 trol kernel: Process grep (pid: 8085, stackpage=ca5c1000)
Feb  7 09:02:03 trol kernel: Stack: 08a34ff8 ce294ffe 0000008f c1448320 c14bfae0 c14bfae0 c01374a6 c0848920
Feb  7 09:02:03 trol kernel:        c14bfae0 c1448320 c14bfae0 ce294000 00000ffe ce294ffa c0848920 cf2399c0
Feb  7 09:02:03 trol kernel:        ce294000 0000008f cf2399fc cfed7940 c01140c6 cfed7940 cf18b260 ca5c1f64
Feb  7 09:02:03 trol kernel: Call Trace: [get_filesystem_info+214/1024] [do_page_fault+358/1136] [mounts_read_proc+34/80]
[proc_file_read+205/432] [sys_read+150/208] [system_call+51/64]
Feb  7 09:02:03 trol kernel:
Feb  7 09:02:03 trol kernel: Code: 8b 45 0c 89 04 24 39 c5 75 17 8b 54 24 20 8b 42 08 39 d0 74

-

                          \\\___///
                         \\  - -  //
                          (  @ @  )
+-----------------------oOOo-(_)-oOOo---------------------------+
|                                                               |
|                     WWW.KUD-KONTRABANT.SI                     |
|                         Janez Vrenjak                         |
|                 mailto:janez@kud-kontrabant.si                |
|                    tel.: +386-(0)41-406 089                   |
|                                                               |
+------------------------------------Oooo-----------------------+
                      oooO          (    )
                     (    )          )  /
                      \  (           (_/
                       \_)
You never hesitate to tackle the most difficult problems.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
