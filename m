Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290721AbSBLCYP>; Mon, 11 Feb 2002 21:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290720AbSBLCYF>; Mon, 11 Feb 2002 21:24:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8071 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290721AbSBLCXw>;
	Mon, 11 Feb 2002 21:23:52 -0500
Date: Mon, 11 Feb 2002 18:22:08 -0800 (PST)
Message-Id: <20020211.182208.102575913.davem@redhat.com>
To: davidm@hpl.hp.com
Cc: anton@samba.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15464.30088.754007.311391@napali.hpl.hp.com>
In-Reply-To: <15464.29104.798819.399971@napali.hpl.hp.com>
	<20020211.174102.28786938.davem@redhat.com>
	<15464.30088.754007.311391@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@hpl.hp.com>
   Date: Mon, 11 Feb 2002 17:53:12 -0800

   Loads are certainly not free on many CPU models.  This is made worse
   by the fact that C alias analysis has to be so pessimistic, especially
   given that the kernel is compiled with -fno-strict-aliasing.

I implemented the thread_info stuff, and I checked out the
performance, have you?
