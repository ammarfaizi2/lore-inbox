Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310666AbSC1ACO>; Wed, 27 Mar 2002 19:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310654AbSC1ACE>; Wed, 27 Mar 2002 19:02:04 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:58807 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S310483AbSC1AB4>; Wed, 27 Mar 2002 19:01:56 -0500
Message-Id: <200203280001.g2S01cb12720@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, pavel@suse.cz (Pavel Machek)
Subject: Re: IDE and hot-swap disk caddies
Date: Thu, 28 Mar 2002 02:01:25 +0200
X-Mailer: KMail [version 1.3.2]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pavel@suse.cz (Pavel Machek),
        andre@linux-ide.org (Andre Hedrick), wakko@animx.eu.org (Wakko Warner),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <E16qMGm-0006J0-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 March 2002 00:51 am, Alan Cox wrote:
> > I have seen USB mass storage devices with ide connector on them, so it
> > is certainly possible to translate between scsi and ide. If it makes
> > sense from performance standpoint.... I don't know.

I have one of these. The performance that I get is really poor and there
are some quirks but it is still useful. I will be _very happy_ when I will be 
able to use it for system installation/upgrade (which did not happen yet).

>
> SCSI->IDE command translation isnt too hard providing you stick to simple
> stuff and blindly ignore things like ATAPI, SMART, and all the control
> stuff. The moment you get into the complex stuff its deeply unfunny.
>

What are the prospects of seeing SCSI and IDE code (and internal
programming interface) unified? How much can be unified until
performace considerations and code complexity mandates a separation?

-- Itai
