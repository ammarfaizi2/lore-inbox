Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVD0Sy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVD0Sy4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVD0Sy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:54:56 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:5321 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261956AbVD0Syh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:54:37 -0400
Subject: Re: [10/07] sparc: Fix PTRACE_CONT bogosity
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wright <chrisw@osdl.org>
Cc: davem@davemloft.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org
In-Reply-To: <20050427183813.GV493@shell0.pdx.osdl.net>
References: <20050427171446.GA3195@kroah.com>
	 <20050427183813.GV493@shell0.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114624397.18355.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Apr 2005 18:53:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-04-27 at 19:38, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> 
> 
> SunOS aparently had this weird PTRACE_CONT semantic which
> we copied.  If the addr argument is something other than
> 1, it sets the process program counter to whatever that
> value is.

7-9 look sane don't see why 10 is a critical issue but then its in arch
specific obscure code and obvious.

Alan

