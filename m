Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310400AbSCGQkJ>; Thu, 7 Mar 2002 11:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310398AbSCGQj7>; Thu, 7 Mar 2002 11:39:59 -0500
Received: from ns.suse.de ([213.95.15.193]:53008 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310400AbSCGQjt>;
	Thu, 7 Mar 2002 11:39:49 -0500
Date: Thu, 7 Mar 2002 17:39:48 +0100
From: Dave Jones <davej@suse.de>
To: Luca Montecchiani <luca.montecchiani@teamfab.it>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Linux 2.2.21pre[23]
Message-ID: <20020307173948.I29587@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Luca Montecchiani <luca.montecchiani@teamfab.it>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E16j0fe-0002m9-00@the-village.bc.nu> <3C879558.A727E265@teamfab.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C879558.A727E265@teamfab.it>; from luca.montecchiani@teamfab.it on Thu, Mar 07, 2002 at 05:29:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 05:29:12PM +0100, Luca Montecchiani wrote:
 > > EIP:    0010:[<c0278bc1>]
 > this is -> x86_serial_nr_setup

 Ok, this doesn't make any sense at all.
 Your original report says the last thing you saw before the oops was
 "CPU serial number disabled."
 
 The code which prints that should run way later than x86_serial_nr_setup
 I'll go stare at the code a bit, and see if something jumps out.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
