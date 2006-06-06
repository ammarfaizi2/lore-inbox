Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWFFOSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWFFOSe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 10:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWFFOSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 10:18:34 -0400
Received: from ns.suse.de ([195.135.220.2]:50901 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932187AbWFFOSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 10:18:33 -0400
From: Andi Kleen <ak@suse.de>
To: Don Zickus <dzickus@redhat.com>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Tue, 6 Jun 2006 16:18:15 +0200
User-Agent: KMail/1.9.3
Cc: Shaohua Li <shaohua.li@intel.com>, Miles Lane <miles.lane@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel@vger.kernel.org
References: <4480C102.3060400@goop.org> <1149576246.32046.166.camel@sli10-desk.sh.intel.com> <20060606141755.GN2839@redhat.com>
In-Reply-To: <20060606141755.GN2839@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606061618.15415.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Because he is using a i386 machine, the nmi watchdog is disabled by
> default. 

I changed that - it's now on by default on i386 too.

-Andi

