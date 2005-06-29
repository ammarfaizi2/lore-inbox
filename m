Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbVF2SzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbVF2SzD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVF2SvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:51:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38272 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262424AbVF2SuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:50:19 -0400
Date: Wed, 29 Jun 2005 11:50:07 -0700
Message-Id: <200506291850.j5TIo72x032190@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Gernot Payer <gpayer@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Patch to disarm timers after an exec syscall
In-Reply-To: Andrew Morton's message of  Wednesday, 29 June 2005 11:15:00 -0700 <20050629111500.61095514.akpm@osdl.org>
X-Zippy-Says: This is my WILLIAM BENDIX memorial CORNER where I worship William
   Bendix like a GOD!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the current code, de_thread already calls exit_itimers to address
exactly this issue.  Can someone please send me the test case that
demonstrates this is not working right?


Thanks,
Roland
