Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278839AbRJaBUb>; Tue, 30 Oct 2001 20:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278837AbRJaBUW>; Tue, 30 Oct 2001 20:20:22 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:37134 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S278833AbRJaBTj>; Tue, 30 Oct 2001 20:19:39 -0500
Message-ID: <3BDF51BE.4450888F@delusion.de>
Date: Wed, 31 Oct 2001 02:19:58 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-ac4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: airlied@csn.ul.ie, linux-kernel@vger.kernel.org
Subject: Re: oops on 2.4.13-pre5 in prune_dcache
In-Reply-To: <200110310054.f9V0sEf01836@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> Something is setting a bit in your dentry. Either RAM errors (do you
> have ECC memory or a history of SIGSEGV's to give any indication either
> way?) or a wild "set_bit()" pointer or similar.

For what it's worth - I've had a very similar oops ages ago. Back then it
was blamed on bad RAM, but ever since then I've run numerous memtest's
over it without finding anything and never had any problems later either.

See here:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0101.0/0303.html

Call Trace is very similar. Maybe it's just coincidence, but who knows.

Regards,
Udo.
