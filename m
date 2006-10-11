Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWJKNcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWJKNcN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWJKNcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:32:13 -0400
Received: from ozlabs.org ([203.10.76.45]:59781 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751289AbWJKNcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:32:12 -0400
Subject: Re: _cpu_down deadlock [was Re: 2.6.19-rc1-mm1]
From: Rusty Russell <rusty@rustcorp.com.au>
To: Neil Brown <neilb@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <17708.60613.451322.747200@cse.unsw.edu.au>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <6bffcb0e0610100610p6eb65726of92b85f7d49e80bb@mail.gmail.com>
	 <6bffcb0e0610100704m32ccc6bakb446671f04b04c2b@mail.gmail.com>
	 <17708.33450.608010.113968@cse.unsw.edu.au>
	 <6bffcb0e0610110348i1d3fc15qa0c57a6586aca3e@mail.gmail.com>
	 <1160565786.3000.369.camel@laptopd505.fenrus.org>
	 <17708.60613.451322.747200@cse.unsw.edu.au>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 23:32:03 +1000
Message-Id: <1160573524.11682.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 23:08 +1000, Neil Brown wrote:
> Who do we blame this on?  Are you still the cpu-hot-plug guy Rusty?

Well, I wasn't the one who introduced locking into notifier chains,
which is the cause from my reading of your explanation...

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

