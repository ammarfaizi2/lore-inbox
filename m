Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbUJZLiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbUJZLiF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbUJZLiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:38:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:53428 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262233AbUJZLh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:37:58 -0400
X-Authenticated: #438326
From: Michael Geithe <warpy@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.10-rc1-bk4 and kernel/futex.c:542
Date: Tue, 26 Oct 2004 13:38:00 +0200
User-Agent: KMail/1.7.1
References: <200410261135.51035.warpy@gmx.de> <20041026133126.1b44fb38@mango.fruits.de> <20041026112415.GA21015@elte.hu>
In-Reply-To: <20041026112415.GA21015@elte.hu>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410261338.00341.warpy@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

first config with > e100

Oct 26 10:57:33 h2so4 kernel: e100: Intel(R) PRO/100 Network Driver, 
3.2.3-k2-NAPI
Oct 26 10:57:33 h2so4 kernel: e100: Copyright(c) 1999-2004 Intel Corporation

Oct 26 11:02:19 h2so4 kernel: Badness in futex_wait at kernel/futex.c:542
Oct 26 11:02:19 h2so4 kernel:  [<c012ba15>] futex_wait+0x180/0x18a
Oct 26 11:02:19 h2so4 kernel:  [<c011532c>] default_wake_function+0x0/0xc
Oct 26 11:02:19 h2so4 kernel:  [<c011532c>] default_wake_function+0x0/0xc
Oct 26 11:02:19 h2so4 kernel:  [<c010a323>] convert_fxsr_from_user+0x15/0xd8
Oct 26 11:02:19 h2so4 kernel:  [<c012bc43>] do_futex+0x35/0x7f
Oct 26 11:02:19 h2so4 kernel:  [<c01dbd77>] copy_from_user+0x34/0x61
Oct 26 11:02:19 h2so4 kernel:  [<c012bd6d>] sys_futex+0xe0/0xec
Oct 26 11:02:19 h2so4 kernel:  [<c0103da5>] sysenter_past_esp+0x52/0x71

and second config with > eepro100

Oct 26 13:12:25 h2so4 kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
Oct 26 13:12:25 h2so4 kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 
Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others

and i dont see this message again.

-- 
Michael Geithe

-





