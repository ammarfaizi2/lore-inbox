Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbSJDEdW>; Fri, 4 Oct 2002 00:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbSJDEdW>; Fri, 4 Oct 2002 00:33:22 -0400
Received: from lightning.adam.com.au ([203.2.124.20]:61193 "HELO
	lightning.adam.com.au") by vger.kernel.org with SMTP
	id <S261476AbSJDEdW>; Fri, 4 Oct 2002 00:33:22 -0400
Message-ID: <3D9D1E8C.AE3423B@adam.com.au>
Date: Fri, 04 Oct 2002 14:22:28 +0930
From: David Lloyd <lloy0076@adam.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-SGI_XFS_1.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: immortal1015 <immortal1015@hotpop.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How to replace the network cards
References: <20021004042315.9F1AF1B84FF@smtp-2.hotpop.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi There,

> Hi, all. Sorry for my stupid problems.

If you weren't called "immortal" I'd forgive you, but if you are a god
surely you would know all!

> I installed Redhat7.2 on my computer and netcard was installed properly.
> I used 'lsmod' and find my network card driver module is 'pcnet32'. Now
> I have modified the source code in pcnet32.c and compile it. How can I
> make my modifications work?

make modules
make modules_install

...should do it unless you've got your pcnet32.c not in its usual place
in the kernel tree.

[ I hope that made sense :-) ]

DSL
-- 
Qualcuno no mi basta.
  Vivere cercando il grande amore.
  Vivere come se mai dovessimo morire.
(Anastasio, Valli e Travato)
