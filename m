Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWDJNBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWDJNBl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 09:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWDJNBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 09:01:41 -0400
Received: from nevyn.them.org ([66.93.172.17]:41169 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1750758AbWDJNBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 09:01:41 -0400
Date: Mon, 10 Apr 2006 09:01:40 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs/binfmt_elf.c:maydump()
Message-ID: <20060410130140.GA20797@nevyn.them.org>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20060406.153518.60508780.davem@davemloft.net> <20060406.221807.114721185.davem@davemloft.net> <20060407180243.GA27828@nevyn.them.org> <20060407.132753.50049697.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407.132753.50049697.davem@davemloft.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 01:27:53PM -0700, David S. Miller wrote:
> Yes, and it would also dump text segments that get written
> by the dynamic linker such as the .plt, which we definitely
> do want.
> 
> It would also dump impure text segment cases as well.

Well, I'm OK with this, upon reflection.  Might as well merge it and
see if anyone else is appalled :-)

-- 
Daniel Jacobowitz
CodeSourcery
