Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbUABDIN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 22:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbUABDIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 22:08:13 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:59756 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263356AbUABDHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 22:07:53 -0500
Date: Thu, 1 Jan 2004 19:07:48 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
Message-Id: <20040101190748.43577763.pj@sgi.com>
In-Reply-To: <m3pte3i17t.fsf@averell.firstfloor.org>
References: <19ahq-7Rg-11@gated-at.bofh.it>
	<19eEs-5lC-15@gated-at.bofh.it>
	<19kgS-4HT-19@gated-at.bofh.it>
	<m3pte3i17t.fsf@averell.firstfloor.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> That was a bug in gcc 3.3.0. It had the -Wsign-compare warning 
> enabled in -Wall by mistake.

Correct.  Even what is now downloadable as:

  ftp://ftp.gnu.org/gnu/gcc/gcc-3.3

seems to have this fixed, and has a gcc/cp/NEWS file entry stating:

     + -Wall no longer implies -W.  The new warning flag, -Wsign-compare,
        included in -Wall, warns about dangerous comparisons of signed and
        unsigned values. Only the flag is new; it was previously part of
        -W.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
