Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVJOKlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVJOKlY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 06:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVJOKlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 06:41:24 -0400
Received: from ns.suse.de ([195.135.220.2]:7821 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751095AbVJOKlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 06:41:23 -0400
Date: Sat, 15 Oct 2005 12:41:19 +0200
From: Karsten Keil <kkeil@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       isdn4linux@listserv.isdn4linux.de
Subject: Re: [PATCH 05/14] Big kfree NULL check cleanup - drivers/isdn
Message-ID: <20051015104119.GA4343@pingi3.kke.suse.de>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, isdn4linux@listserv.isdn4linux.de
References: <200510132127.13778.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510132127.13778.jesper.juhl@gmail.com>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.13-15-default i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2005 at 09:27:13PM +0200, Jesper Juhl wrote:
> This is the drivers/isdn/ part of the big kfree cleanup patch.
> 
> Remove pointless checks for NULL prior to calling kfree() in drivers/isdn/.
> 
> 
> Sorry about the long Cc: list, but I wanted to make sure I included everyone
> who's code I've changed with this patch.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
> 
>  drivers/isdn/hardware/avm/avm_cs.c  |    5 +----
>  drivers/isdn/hisax/avm_pci.c        |   12 ++++--------
>  drivers/isdn/hisax/avma1_cs.c       |    4 +---
>  drivers/isdn/hisax/config.c         |    9 +++------
>  drivers/isdn/hisax/hfc_2bds0.c      |   18 ++++++------------
>  drivers/isdn/hisax/hfc_2bs0.c       |   12 ++++--------
>  drivers/isdn/hisax/hscx.c           |   12 ++++--------
>  drivers/isdn/hisax/icc.c            |   12 ++++--------
>  drivers/isdn/hisax/ipacx.c          |   12 ++++--------
>  drivers/isdn/hisax/isac.c           |   15 ++++++---------
>  drivers/isdn/hisax/isar.c           |    6 ++----
>  drivers/isdn/hisax/jade.c           |   12 ++++--------
>  drivers/isdn/hisax/netjet.c         |   32 ++++++++++----------------------
>  drivers/isdn/hisax/st5481_usb.c     |   12 ++++--------
>  drivers/isdn/hisax/w6692.c          |   12 ++++--------
>  drivers/isdn/hysdn/hysdn_procconf.c |    3 +--
>  drivers/isdn/i4l/isdn_ppp.c         |   21 +++++++--------------
>  drivers/isdn/i4l/isdn_tty.c         |   24 ++++++++----------------
>  drivers/isdn/pcbit/drv.c            |    6 ++----
>  19 files changed, 79 insertions(+), 160 deletions(-)

OK fine with me.

Signed-off-by: Karsten Keil <kkeil@suse.de>


-- 
Karsten Keil
SuSE Labs
ISDN development
