Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSIECXh>; Wed, 4 Sep 2002 22:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSIECXh>; Wed, 4 Sep 2002 22:23:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60899 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316614AbSIECXg>;
	Wed, 4 Sep 2002 22:23:36 -0400
Date: Wed, 04 Sep 2002 19:21:03 -0700 (PDT)
Message-Id: <20020904.192103.18992061.davem@redhat.com>
To: taka@valinux.co.jp
Cc: hpa@zytor.com, paubert@iram.es, linux-kernel@vger.kernel.org
Subject: Re: TCP Segmentation Offloading (TSO)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020905.111326.68164898.taka@valinux.co.jp>
References: <Pine.LNX.4.33.0209050027270.7673-100000@gra-lx1.iram.es>
	<3D768C0F.7040006@zytor.com>
	<20020905.111326.68164898.taka@valinux.co.jp>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hirokazu Takahashi <taka@valinux.co.jp>
   Date: Thu, 05 Sep 2002 11:13:26 +0900 (JST)

   > Better fix is to verify len >=2 before half-word alignment
   > test at the beginning of csum_partial.  I am not enough of
   > an x86 coder to hack this up reliably. :-)
   
   Don't care about the order of checking len and half-word alignment
   as both of them have to be checked after all.
   
I speak of non-PII/PPRO csum_partial.

Franks a lot,
David S. Miller
davem@redhat.com
