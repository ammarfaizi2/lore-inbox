Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWHPGbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWHPGbR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 02:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWHPGbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 02:31:17 -0400
Received: from outgoing3.smtp.agnat.pl ([193.239.44.85]:199 "EHLO
	outgoing3.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S1750941AbWHPGbQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 02:31:16 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1 -resend] Char: mxser, upgrade to 1.9.1
Date: Wed, 16 Aug 2006 08:31:12 +0200
User-Agent: KMail/1.9.4
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       support@moxa.com.tw
References: <mxser191resend3_ee43092305ba163fd5d4@wsc.cz> <20060815225346.cf7ca950.akpm@osdl.org>
In-Reply-To: <20060815225346.cf7ca950.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608160831.12848.arekm@pld-linux.org>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 August 2006 07:53, Andrew Morton wrote:
> On Tue, 15 Aug 2006 04:00:14 -0700
>
> Jiri Slaby <jirislaby@gmail.com> wrote:
> > Change driver according to original 1.9.1 moxa driver. Some int->ulong
> > conversions, outb ~UART_IER_THRI constant. Remove commented stuff.
> >
> > I also added printk line with info, if somebody wants to test it, he
> > should contact me as I can potentially debug the driver with him or just
> > to confirm it works properly.
>
> Ho hum, this is hard.  I guess breaking the driver is one way to find out
> who is using it, but those who redistribute the kernel for a living might
> not appreciate the technique.
>
> Perhaps we could create an mxser-new.c and offer that in config, plan to
> remove mxser.c N months hence?

I can test the updated driver with  MOXA CP-168U series board if it will 
compile on 2.6.12.6. Unfortunately I can't change kernel to latest one there. 
Will testing on 2.6.12.6 be enough for you?

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
