Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265707AbSJXXLB>; Thu, 24 Oct 2002 19:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbSJXXLB>; Thu, 24 Oct 2002 19:11:01 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:29444 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S265707AbSJXXLA>;
	Thu, 24 Oct 2002 19:11:00 -0400
Date: Fri, 25 Oct 2002 08:09:44 +0900 (JST)
Message-Id: <20021025.080944.74754725.taka@valinux.co.jp>
To: manfred@colorfullife.com
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [CFT] faster athlon/duron memory copy implementation
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
References: <3DB82ABF.8030706@colorfullife.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> AMD recommends to perform memory copies with backward read operations 
> instead of prefetch.
> 
> http://208.15.46.63/events/gdc2002.htm
> 
> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu, 
> chipset and memory type?
> 
> Please run 2 or 3 times.

Your test dosen't use cache memory on CPU for the both of src and dst.
We should also try it with a smaller buffer.
