Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263017AbUKYIK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbUKYIK3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 03:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUKYIK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 03:10:28 -0500
Received: from pop.gmx.de ([213.165.64.20]:64396 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263020AbUKYIJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 03:09:57 -0500
Date: Thu, 25 Nov 2004 09:09:56 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: clock@twibright.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20041123234910.GA3488@pclin040.win.tue.nl>
Subject: Re: bug in man netdevice?
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <17929.1101370196@www12.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Nov 23, 2004 at 09:43:20PM +0000, Karel Kulhavy wrote:
> 
> > struct ifreq {
> >            char    ifr_name[IFNAMSIZ];/* Interface name */
> >            union {
> >                    struct sockaddrifr_addr;
> >                    struct sockaddrifr_dstaddr;
> >                    struct sockaddrifr_broadaddr;
> >                    struct sockaddrifr_netmask;
> >                    struct sockaddrifr_hwaddr;
> > 
> > This looks like spaces forgotten between "sockaddr" and ifr_something.
> > Is it a bug? Or is it some elaborate language construct?
> 
> This is not for l-k but for mtk-manpages@gmx.net .
> 
> And to answer your question, there is a tabs line in the source
> that puts the tabs at the wrong positions. Do a
>   1,$s/sockaddr<tab>/sockaddr /

Thanks.  Now fixed in the netdevice.7 page.

Cheers,

Michael

-- 
Geschenkt: 3 Monate GMX ProMail + 3 Top-Spielfilme auf DVD
++ Jetzt kostenlos testen http://www.gmx.net/de/go/mail ++
