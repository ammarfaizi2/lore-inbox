Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTINWkj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 18:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTINWkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 18:40:39 -0400
Received: from ns.suse.de ([195.135.220.2]:9442 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262011AbTINWki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 18:40:38 -0400
To: Russell Miller <rmiller@duskglow.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SUMMARY] rebooting problem solved - athlon/SiS incompatibility.
References: <20030914205429.GA3535@www.duskglow.com.suse.lists.linux.kernel>
	<20030914210429.GA26027@redhat.com.suse.lists.linux.kernel>
	<20030914214132.GA1833@www.duskglow.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Sep 2003 00:39:47 +0200
In-Reply-To: <20030914214132.GA1833@www.duskglow.com.suse.lists.linux.kernel>
Message-ID: <p738yoratak.fsf@nielsen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Miller <rmiller@duskglow.com> writes:

> On Sun, Sep 14, 2003 at 10:04:29PM +0100, Dave Jones wrote:
> 
> ...
> 
> Note the words "an athlon thunderbird processor".  The documentation says, as
> I remember, that turning on SMP on a UP board should have no appreciable effect.

It has the effect of turning on the IO-APIC, which often causes problems.

Check if you can boot with noapic with the SMP kernel

-Andi
