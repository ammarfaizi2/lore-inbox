Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271909AbRIJVeG>; Mon, 10 Sep 2001 17:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271888AbRIJVd4>; Mon, 10 Sep 2001 17:33:56 -0400
Received: from net2.ameuro.de ([62.208.90.8]:58324 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id <S271862AbRIJVdu>;
	Mon, 10 Sep 2001 17:33:50 -0400
Date: Mon, 10 Sep 2001 23:33:47 +0200
From: Anders Larsen <al@alarsen.net>
To: Rick Richardson <rickr@mn.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: QNX4 filesystem hang
Message-ID: <20010910233347.A1936@errol.alarsen.net>
In-Reply-To: <20010908165124.A8236@mn.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010908165124.A8236@mn.rr.com>; from rickr@mn.rr.com on Sat, Sep 08, 2001 at 23:51:02 +0200
X-Mailer: Balsa 1.2.pre3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-09-08 23:51:02 +0200 Rick Richardson wrote:
> 
> I'm running linux kernel 2.4.9.  Trying to use the QNX4 filesystem,
> I get a complete system hang when I do a mount.
> 
> I ran across this guys site:
> 
> 	http://tzukanov.narod.ru/qnx4fs/
> 
> He says to comment out line 399 of inode.c in your driver to fix the
> system hang.  Sure enough, it does the trick.
> 
> Any comments or plans to submit this patch to Linus?

He already got it - it went in with 2.4.10pre5 on the 7.th, so
the world will be okay again when 2.4.10 comes out  :-)

There were some subtle changes between 2.4.7 and 2.4.8 which made this
problem surface, and I wasn't able to reproduce it here (I've been
using 2.4.8 and 2.4.9 (unpatched) without problems with two qnx4
partitions mounted at boot time).

cheers
  Anders
