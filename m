Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267953AbTBVXce>; Sat, 22 Feb 2003 18:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267955AbTBVXce>; Sat, 22 Feb 2003 18:32:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58842 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267953AbTBVXcd>;
	Sat, 22 Feb 2003 18:32:33 -0500
Date: Sat, 22 Feb 2003 15:26:26 -0800 (PST)
Message-Id: <20030222.152626.100079402.davem@redhat.com>
To: wa@almesberger.net
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030222154539.H2791@almesberger.net>
References: <1045874822.25411.3.camel@rth.ninka.net>
	<200302220048.h1M0mjCu020837@turing-police.cc.vt.edu>
	<20030222154539.H2791@almesberger.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Werner Almesberger <wa@almesberger.net>
   Date: Sat, 22 Feb 2003 15:45:39 -0300
   
   4) Back off quickly (i.e. disable ECN on first retry), but keep track
   of whom you had to do this for. Then use some clever user-mode
   strategy module to act on this information. (E.g. send a list of ECN
   offenders to root, or raise the threshold value for turning off ECN
   for destinations that seem to accept ECN in general, but suffer high
   losses.)

Time to write an ipt_ECNLOG.c netfilter module :-)
