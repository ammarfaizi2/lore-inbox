Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWGLBIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWGLBIf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 21:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWGLBIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 21:08:35 -0400
Received: from fmr17.intel.com ([134.134.136.16]:15337 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932319AbWGLBIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 21:08:35 -0400
Message-ID: <44B443E4.1000707@linux.intel.com>
Date: Tue, 11 Jul 2006 17:35:48 -0700
From: James Ketrenos <jketreno@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.4) Gecko/20060711 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Alon Bar-Lev <alon.barlev@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "John W. Linville" <linville@tuxdriver.com>, joesmidt@byu.net,
       linux-kernel@vger.kernel.org
Subject: Re: Will there be Intel Wireless 3945ABG support?
References: <1152635563.4f13f77cjsmidt@byu.edu>	 <20060711171238.GA26186@tuxdriver.com>	 <200607111909.22972.s0348365@sms.ed.ac.uk>  <44B3ED29.4040801@gmail.com> <1152644119.18028.46.camel@localhost.localdomain>
In-Reply-To: <1152644119.18028.46.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Maw, 2006-07-11 am 21:25 +0300, ysgrifennodd Alon Bar-Lev:
>> And to have a system that you know exactly what running in it...
>> Having a binary closed source violate this.
> 
> Also if the binary only chunk of code is neccessary to make the open
> source bit work then its a derivative work as I understand the
> situation, 

Following that logic one must draw the conclusion that the firmware that
runs on a scsi controller is derived from the driver provided with the
kernel that communicates with it.

The obvious distinction between scsi firmware and the regulatory
daemon blob being discussed here is that the regulatory daemon runs on
the host vs. an adapter.  However, if you consider the communication
interface between the kernel and the user space daemon to be analogous
to the communication interface between the kernel driver and the
firmware that runs on an adapter, then the distinction of running on the
host is irrelevant.

> which makes it all rather questionable from a licensing
> perspsective.

There are no questions from a licensing standpoint.

The regulatory daemon is in no way derived from any GPL work, and the
GPL driver is provided with everything it needs to talk to the
interfaces defined through the ipw3945_daemon.h header file.

> Hopefully Intel will find a sensible solution to the problem or someone
> will just reverse engineer it away.

Invariably someone will make such a piece of code available on Linux.

To that end I would encourage anyone that may be interested in using
such a piece of code to read the regulatory notice packaged with our
drivers, and linked for your reference here[1].

James

1.  http://bughost.org/ipw3945/NOTICE

> 
> Alan
