Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbTA1Vvj>; Tue, 28 Jan 2003 16:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbTA1Vvi>; Tue, 28 Jan 2003 16:51:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42763 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S261872AbTA1Vvh>;
	Tue, 28 Jan 2003 16:51:37 -0500
Date: Tue, 28 Jan 2003 16:59:43 -0500
From: Christopher Faylor <cgf@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: benoit-lists@fb12.de, kuznet@ms2.inr.ac.ru, dada1@cosmosbay.com,
       andersg@0x63.nu, lkernel2003@tuxers.net, linux-kernel@vger.kernel.org,
       tobi@tobi.nu
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
Message-ID: <20030128215943.GA2019@redhat.com>
References: <200301281409.RAA28740@sex.inr.ac.ru> <20030128.103534.115458142.davem@redhat.com> <20030128201645.A29746@turing.fb12.de> <20030128.123413.51821993.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030128.123413.51821993.davem@redhat.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 12:34:13PM -0800, David S. Miller wrote:
>   From: Sebastian Benoit <benoit-lists@fb12.de>
>   Date: Tue, 28 Jan 2003 20:16:45 +0100
>
>   David S. Miller(davem@redhat.com)@2003.01.28 10:35:34 +0000:
>   > Good set of debug checks would be the following:
>   
>   no output, i did 4 tests, everytime i was able to lock the ssh-connection
>   within a few seconds. kernel 2.5.59 + your debug-patch.
>
>Thanks for testing, how about this new patch at the end of this email?
>Does it make the problem go away?

It does for me, yes.  I tried very hard to make ssh hang but I couldn't do
so.

cgf
