Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWJBKKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWJBKKy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 06:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWJBKKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 06:10:54 -0400
Received: from main.gmane.org ([80.91.229.2]:51165 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750721AbWJBKKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 06:10:53 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: How is Code in do_sys_settimeofday() safe in case of SMP and Nest Kernel Path?
Date: 02 Oct 2006 12:08:08 +0200
Message-ID: <87mz8fm3nb.fsf@willow.rfc1149.net>
References: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com> <a2ebde260609290916j3a3deb9g33434ca5d93e7a84@mail.gmail.com> <451E8143.5030300@yahoo.com.au> <200609301703.45364.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zaphod.rfc1149.net
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Leafnode-NNTP-Posting-Host: 2001:6f8:37a:2::2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andi" == Andi Kleen <ak@suse.de> writes:

>> Did you get to the bottom of this yet? It looks like you're right,
>> and I suggest a seqlock might be a good option.

Andi> It basically doesn't matter because nobody changes the time zone
Andi> after boot.

I do when I travel, and my laptop has a dual-core processor.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

