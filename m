Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279617AbRJ2X3k>; Mon, 29 Oct 2001 18:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279623AbRJ2X3c>; Mon, 29 Oct 2001 18:29:32 -0500
Received: from ix.esoft.com ([199.45.143.3]:44293 "EHLO esoft.com")
	by vger.kernel.org with ESMTP id <S279616AbRJ2X2h>;
	Mon, 29 Oct 2001 18:28:37 -0500
Message-ID: <3BDDE642.8000901@acm.org>
Date: Mon, 29 Oct 2001 16:29:06 -0700
From: Jonathan Briggs <zlynx@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
In-Reply-To: <E15yJD1-0003uO-00@the-village.bc.nu> <3BDDBE89.397E42C0@lexus.com> <20011029124753.F21285@one-eyed-alien.net> <4.3.2.7.2.20011029172525.00bb2270@mail.osagesoftware.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A 32 bit uptime patch should also include a new kernel parameter that 
could be passed from LILO: uptime.  Then you could test the uptime patch 
by passing uptime=4294967295

Or make /proc/uptime writable.

David Relson wrote:

> Let's assume you have the counter changed to 32 bits - RIGHT NOW 
> (tm).  Build a kernel, install it, reboot.  It'll be over a year 
> (approx Jan 2003) before the change will be noticeable...
>
> Methinks that's a long time to wait for a result :-)
>
> David
>


