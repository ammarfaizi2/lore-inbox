Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132914AbRDQWbj>; Tue, 17 Apr 2001 18:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132919AbRDQWbU>; Tue, 17 Apr 2001 18:31:20 -0400
Received: from spc2.esa.lanl.gov ([128.165.67.191]:53953 "HELO
	spc2.esa.lanl.gov") by vger.kernel.org with SMTP id <S132914AbRDQWbK>;
	Tue, 17 Apr 2001 18:31:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: alan@lxorguk.ukuu.org.uk
Subject: 2.4.3-ac8 build error with CONFIG_DEBUG_KERNEL not set
Date: Tue, 17 Apr 2001 16:37:17 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, elenstev@mesatop.com
MIME-Version: 1.0
Message-Id: <01041716371704.01250@spc2.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following with CONFIG_DEBUG_KERNEL not set:

kernel/kernel.o(__ksymtab+0xc80): undefined reference to `handle_sysrq'
kernel/kernel.o(__ksymtab+0xc88): undefined reference to `__handle_sysrq_nolock'
kernel/kernel.o(__ksymtab+0xc90): undefined reference to `__sysrq_lock_table'
kernel/kernel.o(__ksymtab+0xc98): undefined reference to `__sysrq_unlock_table'
kernel/kernel.o(__ksymtab+0xca0): undefined reference to `__sysrq_get_key_op'
kernel/kernel.o(__ksymtab+0xca8): undefined reference to `__sysrq_put_key_op'
make: *** [vmlinux] Error 1

However, with CONFIG_DEBUG_KERNEL and CONFIG_MAGIC_SYSRQ set to y,
I got a clean build. 

Steven

