Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268824AbUJUQve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268824AbUJUQve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 12:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270418AbUJUQvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 12:51:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42904 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268824AbUJUQtw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 12:49:52 -0400
Message-ID: <4177E8A0.2090508@pobox.com>
Date: Thu, 21 Oct 2004 12:49:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Len Brown <len.brown@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Versioning of tree
References: <1098254970.3223.6.camel@gaston> <1098256951.26595.4296.camel@d845pe> <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Now, personally, I'd actually like to know the exact top-of-tree
> changeset, so I've considered having something that saves that one away,
> but then we'd need to do something about non-BK users (make the nightly 
> snapshots squirrell it away somewhere too). That would solve both the 
> module versioning _and_ the bug-report issue.


The nightly snapshots have been exporting this info since Day One, based 
on your request ;-)

<snapshot>.key contains this info, e.g.
http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.9-bk1.key
	is T.O.T. for
http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.9-bk1.bz2

