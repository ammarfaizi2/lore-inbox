Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268137AbTCFRCx>; Thu, 6 Mar 2003 12:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268131AbTCFRCw>; Thu, 6 Mar 2003 12:02:52 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2499 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268137AbTCFRCL>;
	Thu, 6 Mar 2003 12:02:11 -0500
Date: Thu, 06 Mar 2003 08:53:19 -0800 (PST)
Message-Id: <20030306.085319.85616559.davem@redhat.com>
To: laforge@netfilter.org
Cc: bunk@fs.tum.de, cat@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] remove EXPORT_NO_SYMBOLS from ip6tables code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030306010920.GN4880@sunbeam.de.gnumonks.org>
References: <20030305153259.GE2075@zip.com.au>
	<20030305220542.GM20423@fs.tum.de>
	<20030306010920.GN4880@sunbeam.de.gnumonks.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Harald Welte <laforge@netfilter.org>
   Date: Thu, 6 Mar 2003 02:09:20 +0100

   On Wed, Mar 05, 2003 at 11:05:42PM +0100, Adrian Bunk wrote:
   > The patch that added new ip6tables matches in 2.5.64 added seven 
   > occurances of the obsolete EXPORT_NO_SYMBOLS. The patch below removes 
   > them.
   
   Thanks, this was my fault.  I submitted one patch (for 2.4 and 2.5) to
   davem... and obviously this is no longer possible with the intrusive
   changes of 2.5.x ...
   
   Davem, please include this into your 2.5.x tree. Thanks.

Applied, thanks.
