Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310389AbSCGQ1H>; Thu, 7 Mar 2002 11:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310398AbSCGQ05>; Thu, 7 Mar 2002 11:26:57 -0500
Received: from [151.17.201.167] ([151.17.201.167]:47114 "EHLO mail.teamfab.it")
	by vger.kernel.org with ESMTP id <S310389AbSCGQ0y>;
	Thu, 7 Mar 2002 11:26:54 -0500
Message-ID: <3C879558.A727E265@teamfab.it>
Date: Thu, 07 Mar 2002 17:29:12 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-i586-SMP-modular i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>
Subject: Re: [OOPS] Linux 2.2.21pre[23]
In-Reply-To: <E16j0fe-0002m9-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
:

> EIP:    0010:[<c0278bc1>]

this is -> x86_serial_nr_setup

> You want EIP and the call trace. Then look those up in System.map

and finally we have:

empty_bad_page -> get_options -> L6

I can test any patch in the next hour or tomorrow ;)
