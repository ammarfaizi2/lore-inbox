Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264675AbRFTXRw>; Wed, 20 Jun 2001 19:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbRFTXRm>; Wed, 20 Jun 2001 19:17:42 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31586 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263016AbRFTXR1>; Wed, 20 Jun 2001 19:17:27 -0400
Date: Thu, 21 Jun 2001 01:16:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, paulus@samba.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: softirq in pre3 and all linux ports
Message-ID: <20010621011642.A9153@athlon.random>
In-Reply-To: <20010620060753.B849@athlon.random> <200106201806.WAA19422@ms2.inr.ac.ru> <15153.8005.551628.544731@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15153.8005.551628.544731@pizda.ninka.net>; from davem@redhat.com on Wed, Jun 20, 2001 at 03:10:13PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2001 at 03:10:13PM -0700, David S. Miller wrote:
> TUX also has per-cpu timers patch of Ingo as well.

Not in my tree, tux doesn't depend on it at all. that's a further
optimization that tcp will take advatage of regardless of tux, same
applies to the pagecache scalability hashlock patch.

Andrea
