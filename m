Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbTCLWT2>; Wed, 12 Mar 2003 17:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262074AbTCLWT2>; Wed, 12 Mar 2003 17:19:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:9602 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262076AbTCLWT0>;
	Wed, 12 Mar 2003 17:19:26 -0500
Date: Wed, 12 Mar 2003 14:29:51 -0800 (PST)
Message-Id: <20030312.142951.76164766.davem@redhat.com>
To: jjs@tmsusa.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: named vs 2.5.64-mm5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3E6FB472.20809@tmsusa.com>
References: <20030312113126.703de259.akpm@digeo.com>
	<1047503813.17931.2.camel@rth.ninka.net>
	<3E6FB472.20809@tmsusa.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jjs <jjs@tmsusa.com>
   Date: Wed, 12 Mar 2003 14:28:02 -0800

   So, the SO_BSDCOMPAT messages are in all
   likelihood unrelated to the problems I'm seeing
   with bind-9.2.1 under 2.5.6x-recent kernels...
   
   I guess I'll have to turn up the debugging on
   bind and see if anything unusual pops up -
   
If bind errors internally because it cannot
set SO_BSDCOMPAT, this is likely the problem.

You need to hack the bind sources to remove references
to SO_BSDCOMPAT.
