Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319858AbSINHmd>; Sat, 14 Sep 2002 03:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319859AbSINHmd>; Sat, 14 Sep 2002 03:42:33 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:64522 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S319858AbSINHmd>;
	Sat, 14 Sep 2002 03:42:33 -0400
Date: Sat, 14 Sep 2002 16:39:33 +0900 (JST)
Message-Id: <20020914.163933.132924824.taka@valinux.co.jp>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janetmor@us.ibm.com
Subject: Re: [patch] readv/writev rework
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3D82C0F1.8733207D@digeo.com>
References: <20020913.101826.32726068.taka@valinux.co.jp>
	<3D815C04.A08CB5D9@digeo.com>
	<3D82C0F1.8733207D@digeo.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Brilliant!
It's great than I expected.

> > So Janet's patch made a 15% improvement with this test.  Yours
> > dropped it 50% again.
> > 
> 
> I've retested with your latest patch.
> 
>                    2.5.34-mm4-taka2
> write                  55.543
> fwrite                 12.625
> fwrite_unlocked        11.389
> writev                  9.219
> 
> So that's another 70% speedup on top of yesterday's 100%, and kernel
> beats glibc ;)

Thanks for your testing my patch and your detailed explanation.

Hirokazu Takahashi.
