Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287557AbRLaQVH>; Mon, 31 Dec 2001 11:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287558AbRLaQU5>; Mon, 31 Dec 2001 11:20:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61964 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287557AbRLaQUk>;
	Mon, 31 Dec 2001 11:20:40 -0500
Message-ID: <3C309055.E082333E@mandrakesoft.com>
Date: Mon, 31 Dec 2001 11:20:37 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Girish Hilage <girish@bombay.retortsoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: how to map network cards ?
In-Reply-To: <20011231212412.A10338@alice.bombay.retortsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Girish Hilage wrote:
> 
> Hello everybody,
> 
>  This is my first mail to the list. I want to know, what /sbin/lspci outputs are nothing but the contents of '/proc/bus/pci/devices' in a readable form?
> 
>  And if so how do I know which entry implies which network interface (e.g. eth0, eth1 etc.)?


You can only figure out a network card<->PCI bus mapping using
ETHTOOL_GDRVINFO ioctl.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
