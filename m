Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261808AbTCTTSt>; Thu, 20 Mar 2003 14:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261817AbTCTTSt>; Thu, 20 Mar 2003 14:18:49 -0500
Received: from havoc.daloft.com ([64.213.145.173]:5589 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261808AbTCTTSs>;
	Thu, 20 Mar 2003 14:18:48 -0500
Date: Thu, 20 Mar 2003 14:29:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Yaroslav Popovitch <yp@sot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ptrace bug fix is not working!!!
Message-ID: <20030320192943.GE8256@gtf.org>
References: <Pine.LNX.4.44.0303202114350.30893-301000@ares.sot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303202114350.30893-301000@ares.sot.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 09:23:28PM +0200, Yaroslav Popovitch wrote:
> Hi! I applied Alan Cox's patches for ptrace bug. But system is still 
> exploitable.
> 
> I used my own kernel-2.4.19 with patch for 2.4.19 kernel. It does not 
> helped. Then I took vanilla 2.4.20 kernel from www.kernel.org and applied 
> patch for 2.4.20 kernel. System is still exploitable.

Can you verify that you are clearing the setuid bit that gets set, when
the exploit is run?  IIRC, you must manually do that to verify that your
system is indeed no longer exploitable.

	Jeff




