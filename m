Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbTI3M2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbTI3M2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:28:31 -0400
Received: from rth.ninka.net ([216.101.162.244]:12675 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261407AbTI3M20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:28:26 -0400
Date: Tue, 30 Sep 2003 05:28:17 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
Message-Id: <20030930052817.0d0272df.davem@redhat.com>
In-Reply-To: <20030930120629.GM2908@suse.de>
References: <200309301157.h8UBvOcd004345@burner.fokus.fraunhofer.de>
	<20030930120629.GM2908@suse.de>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003 14:06:29 +0200
Jens Axboe <axboe@suse.de> wrote:

> I asked you one simple question: when did the kernel/user interface
> break, and how?

I'll answer for him, about 20 or 30 times during IPSEC development.
It's still possible this could change even some more before 2.6.0
final is released if a large enough bug in the IPSEC socket APIs are
found in time.

But that's not the important issue, the important issue is that
a huge number of kernel API interfaces have no equivalent in
whatever you consider to be "user usable non-kernel headers".

Find me the API defines for the IPSEC configuration socket interfaces
in a header file that you think users should be allowed to include.

You won't find it Jens, and that's why it drives me nuts when people
spit out the "no kernel headers" mantra.  Often it simply must be
done as a matter of practicality.
