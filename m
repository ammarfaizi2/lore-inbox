Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbTKUDWZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 22:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbTKUDWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 22:22:25 -0500
Received: from are.twiddle.net ([64.81.246.98]:41614 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S264283AbTKUDWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 22:22:23 -0500
Date: Thu, 20 Nov 2003 19:22:16 -0800
From: Richard Henderson <rth@twiddle.net>
To: Buck Rekow <rekow@bigskytel.com>
Cc: linux-kernel@vger.kernel.org, breed@users.sourceforge.net,
       achirica@users.sourceforge.net
Subject: Re: PROBLEM: Aironet compile failure 2.6-test9/Alpha architecture
Message-ID: <20031121032216.GA12185@twiddle.net>
Mail-Followup-To: Buck Rekow <rekow@bigskytel.com>,
	linux-kernel@vger.kernel.org, breed@users.sourceforge.net,
	achirica@users.sourceforge.net
References: <3FBD67E7.5020405@bigskytel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBD67E7.5020405@bigskytel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 06:18:31PM -0700, Buck Rekow wrote:
> drivers/net/wireless/airo.c: In function `emmh32_setseed':
> drivers/net/wireless/airo.c:1458: internal error--unrecognizable insn:
> (insn:TI 512 478 513 (set (reg:DI 1 $1)
>        (plus:DI (reg:DI 30 $30)
>            (const_int 4398046511104 [0x40000000000]))) -1 (insn_list 51 
> (insn_list:REG_DEP_ANTI 494 (nil)))
>    (nil))

This is always a compiler bug.

> Gnu C                  2.95.4

File a bug with Debian if you want, but the GCC folk proper
aren't even going to look at something this old.


r~
