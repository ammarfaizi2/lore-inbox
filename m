Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318975AbSICXKx>; Tue, 3 Sep 2002 19:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318982AbSICXKx>; Tue, 3 Sep 2002 19:10:53 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:20749 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S318975AbSICXKw>;
	Tue, 3 Sep 2002 19:10:52 -0400
Date: Wed, 04 Sep 2002 08:08:44 +0900 (JST)
Message-Id: <20020904.080844.74753856.taka@valinux.co.jp>
To: manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP Segmentation Offloading (TSO)
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3D74FAD9.5050108@colorfullife.com>
References: <3D74FAD9.5050108@colorfullife.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Hirokazu Takahashi wrote:
> > P.S.
> >     Using "bswap" is little bit tricky.
> > 
> 
> bswap was added with the 80486 - 80386 do not have that instruction, 
> perhaps it's missing in some embedded system cpus, too. Is is possible 
> to avoid it?

There are two kinds of csum_partial() for x86.
I just added bswap to PII/PPro csum_partial() 

