Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266294AbTGEHTo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 03:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbTGEHTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 03:19:44 -0400
Received: from [213.39.233.138] ([213.39.233.138]:22758 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S266294AbTGEHTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 03:19:43 -0400
Date: Sat, 5 Jul 2003 09:33:44 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paul Mackerras <paulus@samba.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org,
       anton@au.ibm.com, engebret@us.ibm.com
Subject: Re: [PATCH 2.5.73] Signal handling fix for ppc
Message-ID: <20030705073344.GC32363@wohnheim.fh-wedel.de>
References: <20030703202410.GA32008@wohnheim.fh-wedel.de> <20030704174339.GB22152@wohnheim.fh-wedel.de> <20030704174558.GC22152@wohnheim.fh-wedel.de> <20030704175439.GE22152@wohnheim.fh-wedel.de> <20030704175859.GF22152@wohnheim.fh-wedel.de> <16134.3376.132454.633616@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16134.3376.132454.633616@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 July 2003 09:26:40 +1000, Paul Mackerras wrote:
> 
> OK.  The changes are OK in principle but your patch is a bit borken
> since you add a check "if (sig == SIGSEGV)" in sys_sigreturn and
> sys_rt_sigreturn, but there is no variable called "sig" in those
> functions.

Yes, I just did stupid copy'n'paste.

> I have some other signal changes pending.  I'll roll in your changes
> and push it on to Linus shortly.

Cool, thanks!

Jörn

-- 
Do not stop an army on its way home.
-- Sun Tzu
