Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263756AbRFRIQ4>; Mon, 18 Jun 2001 04:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263766AbRFRIQg>; Mon, 18 Jun 2001 04:16:36 -0400
Received: from 202-54-39-145.tatainfotech.co.in ([202.54.39.145]:55568 "EHLO
	brelay.tatainfotech.com") by vger.kernel.org with ESMTP
	id <S263756AbRFRIQa>; Mon, 18 Jun 2001 04:16:30 -0400
Date: Mon, 18 Jun 2001 14:05:35 +0530 (IST)
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: linux-kernel@vger.kernel.org
Subject: Reg:current a pointer to task_struct
In-Reply-To: <Pine.LNX.4.10.10106181324110.11158-100000@blrmail>
Message-ID: <Pine.LNX.4.10.10106181403400.9461-100000@blrmail>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please help me with the following:

I tried to go through get_current function which is in assembly.

static inline struct task_struct * get_current(void) {
        struct task_struct *current;
        __asm__("andl %%esp,%0; ":"=r" (current) : "0" (~8191UL));
        return current;
 }


Please tell me what is done here. Does current refer to process onproc.


Thanks in advance,
Regards,
sathish


