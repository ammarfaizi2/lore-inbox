Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266787AbUHIRkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266787AbUHIRkr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266792AbUHIRkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:40:47 -0400
Received: from embeddededge.com ([209.113.146.155]:8197 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S266787AbUHIRkp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:40:45 -0400
In-Reply-To: <20040809165650.GA22109@smtp.west.cox.net>
References: <4108F845.7080305@timesys.com> <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com> <A46787F8-E194-11D8-B8DB-003065F9B7DC@embeddededge.com> <410A5F08.90103@timesys.com> <410A67EA.80705@timesys.com> <20040809165650.GA22109@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6FBD1B21-EA2B-11D8-8382-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: Kumar Gala <kumar.gala@freescale.com>, LKML <linux-kernel@vger.kernel.org>,
       Greg Weeks <greg.weeks@timesys.com>,
       LinuxPPC-dev Development <linuxppc-dev@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [BUG] PPC math-emu multiply problem
Date: Mon, 9 Aug 2004 13:42:08 -0400
To: Tom Rini <trini@kernel.crashing.org>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Aug 9, 2004, at 12:56 PM, Tom Rini wrote:

> Has anyone had a problem with this?  If not, I'll go and pass it
> along...

The default rounding mode should be whatever is defined
by IEEE.  I thought the emulator used the proper default value
and if want something different it should be selected by
the control register.  Maybe the emulator isn't implementing
the control register properly.

Thanks.

	-- Dan

