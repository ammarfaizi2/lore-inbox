Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287565AbRLaQlI>; Mon, 31 Dec 2001 11:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287562AbRLaQk6>; Mon, 31 Dec 2001 11:40:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5133 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287559AbRLaQkq>;
	Mon, 31 Dec 2001 11:40:46 -0500
Message-ID: <3C30950A.F58038F0@mandrakesoft.com>
Date: Mon, 31 Dec 2001 11:40:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
CC: girish@bombay.retortsoft.com, linux-kernel@vger.kernel.org
Subject: Re: how to map network cards ?
In-Reply-To: <200112311632.KAA51999@tomcat.admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> The only way to determine
> the ACTUAL eth0 is via mac number and trial and error.

not correct, as noted in other e-mail.

> I configure ONE interface (all others are down), then plug in to a working
> network.
> 
> If I can ping the other machine then I know which network a given
> interface is on - label it.
> 
> Now down that interface, and initialize another one. Repeat until all
> interfaces are identified.

also note that one can rename interfaces, or in the future they might
appear out-of-order.  To only way to be obsolutely certain where a
network device is on the PCI bus is ETHTOOL_GDRVINFO.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
