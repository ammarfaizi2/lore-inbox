Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbUD2BZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUD2BZB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUD2BZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:25:01 -0400
Received: from main.gmane.org ([80.91.224.249]:9161 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262488AbUD2BY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:24:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Neal Becker <ndbecker2@verizon.net>
Subject: Re:  State of linux checkpointing?
Date: Wed, 28 Apr 2004 21:24:55 -0400
Message-ID: <c6plh7$sqj$1@sea.gmane.org>
References: <c6oorn$3dq$1@sea.gmane.org> <409012A4.9000502@pobox.com> <slrn-0.9.7.4-11992-4650-200404290913-tc@hexane.ssi.swin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pool-68-236-247-103.hag.east.verizon.net
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Connors wrote:

> Jeff Garzik <jgarzik@pobox.com> said on Wed, 28 Apr 2004 16:23:00 -0400:
>> Neal D. Becker wrote:
>> > I wonder if there is a checkpointing that will work with 2.6 kernels?
>> > 
>> > I only need relatively basic checkpointing.  No sockets or fancy stuff.
>> 
>> You only need checkpointing when your application programmers are lazy
>> and don't care about data integrity.  :)
> 
> Or you are running some kind of cluster where you want the
> applications to be checkpointed transparently without the application
> knowing the details of how or when they will be swapped out (but this
> will need sockets anyway, so won't happen anytime soon).
> 

I want checkpointing for:

1) Protect against job interruption due to system crash, operator error,
power loss, whatever

2) Job mygration.  Even manual job mygration would be nice.


