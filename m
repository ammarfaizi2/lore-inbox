Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbRE1XFt>; Mon, 28 May 2001 19:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261513AbRE1XFj>; Mon, 28 May 2001 19:05:39 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:19474 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S261505AbRE1XF0>;
	Mon, 28 May 2001 19:05:26 -0400
Message-ID: <3B12D212.28C2B01D@bigfoot.com>
Date: Mon, 28 May 2001 16:32:50 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Broken memory init on VIA KX133
In-Reply-To: <E154UXz-0003Yl-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> >       I'm wondering if anyone knows/has a fix for memory past 64mb not
being
> > detected (unless you use append="mem=...M" in lilo) on the Via VT8371
> > [KX133] North bridge.   (Please CC any replies since I'm off kernel list
> > atm.)
> 
> Consult your BIOS vendor

Actually, I just did some additional testing (as this was not an issue with
FreebSD 4.2, Win2k, Win98 on the same hardware).  The problem I describe was
fixed in 2.2.19 -- where Linux now properly uses e820 instead of a legacy
BIOS call to determine memory size.

--
    www.kuro5hin.org -- technology and culture, from the trenches.
