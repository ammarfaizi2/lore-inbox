Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291072AbSBLOSY>; Tue, 12 Feb 2002 09:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291078AbSBLOSO>; Tue, 12 Feb 2002 09:18:14 -0500
Received: from mail.spylog.com ([194.67.35.220]:41639 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S291072AbSBLOSD>;
	Tue, 12 Feb 2002 09:18:03 -0500
Date: Tue, 12 Feb 2002 17:17:56 +0300
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: [? bug] 2.4.18pre2aa2
Message-ID: <20020212141756.GA17812@an.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

1. 1 CPU, 2Gb RAM, highmem 4Gb.

2.

...
Feb  5 12:13:50 hydra kernel: Symbols match kernel version 2.4.18.
Feb  5 12:13:50 hydra kernel: No module symbols loaded - kernel modules not enabled. 
Feb  8 18:56:52 hydra kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Feb  8 18:56:53 hydra kernel: f194fe54 e0256ee0 00000000 000001d2 00000000 00104025 00000001 e6b7d45c 
Feb  8 18:56:53 hydra kernel:        e42cf494 00000001 00000002 e02a95c0 e02a96b0 00000000 000001d2 00000000 
Feb  8 18:56:53 hydra kernel:        e011f221 91917000 00000001 e6b7d45c ed6b6954 e011f352 e42cf494 ed6b6954 
Feb  8 18:56:53 hydra kernel: Call Trace: [proc_doulongvec_minmax+17/44] [sysctl_string+186/300] [check_free_space+130/712] [mtrr_file_del+82/124]
[mtrr_del_page+376/436] 
Feb  8 18:56:53 hydra kernel:    [do_acct_process+619/836] [do_syslog+39/1936] [do_syslog+516/1936] [do_syslog+1147/1936]
[interruptible_sleep_on_timeout+106/324] [interruptible_sleep_on+213/304] 
Feb  8 18:56:53 hydra kernel:    [wait_for_completion+90/404] [setup_frame+412/436] 
Feb  8 18:56:53 hydra kernel: VM: killing process layers
...
    



-- 
bye.
Andrey Nekrasov, SpyLOG.
