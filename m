Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291373AbSBMFGU>; Wed, 13 Feb 2002 00:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291374AbSBMFGK>; Wed, 13 Feb 2002 00:06:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64649 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291373AbSBMFF7>;
	Wed, 13 Feb 2002 00:05:59 -0500
Date: Tue, 12 Feb 2002 21:04:06 -0800 (PST)
Message-Id: <20020212.210406.95506209.davem@redhat.com>
To: akpm@zip.com.au
Cc: davlarso@acm.org, linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de
Subject: Re: Is this a bug in TCP or the PCNet32 driver?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C69771E.17F26646@zip.com.au>
In-Reply-To: <Pine.GSO.4.31.0202120728000.24018-100000@linus.davelarson.net>
	<3C69771E.17F26646@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Tue, 12 Feb 2002 12:12:14 -0800
   
   Yup.  Tx interrupt mitigation like this is a really neat feature. It
   can make a huge improvement in performance.  But the driver does need
   to implement a timer to fix the problem which you have described.

This reminds me how sick I am of drivers that don't define what the
heck the bits mean in the registers and descriptor flags.

Something for the Janitors I guess.
