Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279271AbRJWGKe>; Tue, 23 Oct 2001 02:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279272AbRJWGKY>; Tue, 23 Oct 2001 02:10:24 -0400
Received: from mail126.mail.bellsouth.net ([205.152.58.86]:11102 "EHLO
	imf26bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279271AbRJWGKI>; Tue, 23 Oct 2001 02:10:08 -0400
Message-ID: <3BD509F3.B306361E@mandrakesoft.com>
Date: Tue, 23 Oct 2001 02:10:59 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: (WAN) network device status
In-Reply-To: <m3itd7rcou.fsf@defiant.pm.waw.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> I remember a discussion about net_dev->flags and carrier loss etc
> detection. Did the things change? I mean, do we currently have a way
> for network device driver to report (to the rest of kernel, to the
> userland) that the link is down? It would include DCD (carrier) loss,
> Ethernet link down, IrDA/USB disconnects etc.

We have netif_carrier_{on,off}, and longer term netlink should
proactively deliver link up/down messages.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

