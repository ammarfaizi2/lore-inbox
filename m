Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268514AbRG3LiE>; Mon, 30 Jul 2001 07:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268516AbRG3Lhx>; Mon, 30 Jul 2001 07:37:53 -0400
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:45015 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S268514AbRG3Lhg>; Mon, 30 Jul 2001 07:37:36 -0400
Date: Tue, 31 Jul 2001 05:30:15 +1000
From: Glenn <bug1@optushome.com.au>
To: thierry@cri74.org
Cc: debian-boot@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PCI] building PCI IDs/drivers DB from Linux kernel sources
Message-Id: <20010731053015.5d098517.bug1@optushome.com.au>
In-Reply-To: <20010730113319.A24939@pc04.cri.cur-archamps.fr>
In-Reply-To: <20010730113319.A24939@pc04.cri.cur-archamps.fr>
X-Mailer: Sylpheed version 0.5.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001 11:33:19 +0200
"Thierry Laronde" <thierry@cri74.org> wrote:

> 
> In order to allow a kind of light detection of hardware to be use during
> installation, I wanted to build a database (for PCI: I start with the
> easiest...) with the following format:
> 
> CLASS_ID	VENDOR_ID	DEVICE_ID	driver_name
> 
> I have decided to write a script (you will find all the stuff attached)
> parsing the Linux kernel sources in order to do that.
> 
<snip>
> 
> Note: The DB constructed is _not_ garanty to be bullet proof. For example,
> since this is only alpha tests, the class id are probably wrong for some
> devices. Comments absolutely welcomed.

I imported your db into gnumeric, sorted it to put the driver first,
converted it to html (and .csv).

http://people.debian.org/~bug1/dmod/linux-2.4.6-i386-pci.html

A couple of possible problem entries

The comma in the following
53c7,8xx  256  4096  1
53c7,8xx  256  4096  2
53c7,8xx  256  4096  3
53c7,8xx  256  4096  4

and no number for device_id
saa9730  512  4401  PCI_DEVICE_ID_PHILIPS_SAA9730
pmc551  512  4528  PCI_DEVICE_ID_V3_SEMI_V370PDC

(im not subscribed to lk-ml)


Glenn
