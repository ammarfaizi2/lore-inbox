Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUBKRbe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 12:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265966AbUBKRbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 12:31:33 -0500
Received: from ns.suse.de ([195.135.220.2]:3535 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265928AbUBKRbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 12:31:32 -0500
Date: Sat, 14 Feb 2004 20:43:26 +0100
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: ap@swapped.cc, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] [2/2] hlist: remove IFs from hlist functions
Message-Id: <20040214204326.4d9fc423.ak@suse.de>
In-Reply-To: <20040214195949.2ad9aa4f.ak@suse.de>
References: <4029CB7E.4030003@swapped.cc.suse.lists.linux.kernel>
	<4029CF24.1070307@osdl.org.suse.lists.linux.kernel>
	<4029D2D5.7070504@swapped.cc.suse.lists.linux.kernel>
	<p73y8ra5721.fsf@nielsen.suse.de>
	<402A5CEC.2030603@swapped.cc>
	<20040214195949.2ad9aa4f.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Feb 2004 19:59:49 +0100
Andi Kleen <ak@suse.de> wrote:
> 
> A full cache miss is extremly costly on a modern Gigahertz+ CPU because
> memory and busses are far slower than the CPU core. As a rule of 
> thumb 1000+ cycles. An CMP is extremly cheap (a few cycles at worst), 
> the only thing that could be more expensive is an mispredicted conditional
> jump triggered  by the CMP. But even that would be at best a few tens of cycles.
> If everything is mispredicted which should be common it's extremly fast
                   ^^^^^^^^^^^^^
                   predicted of course

-Andi
