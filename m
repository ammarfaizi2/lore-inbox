Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWESK2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWESK2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 06:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWESK2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 06:28:12 -0400
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:15251 "EHLO
	gw03.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S932238AbWESK2M (ORCPT <rfc822;<linux-kernel@vger.kernel.org>>);
	Fri, 19 May 2006 06:28:12 -0400
From: Jan Knutar <jk-lkml@sci.fi>
To: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [OT] replacing X Window System !
Date: Fri, 19 May 2006 13:27:52 +0300
User-Agent: KMail/1.6.2
References: <20060516214148.14432.qmail@web26611.mail.ukl.yahoo.com> <6f6293f10605161610p28358fb6p35c85a30c9a2c1f4@mail.gmail.com> <446AE301.3060302@rainbow-software.org>
In-Reply-To: <446AE301.3060302@rainbow-software.org>
Cc: linux cbon <linuxcbon@yahoo.fr>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200605191327.52662.jk-lkml@sci.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is slow. Just take any older machine (Pentium class), open any longer 
> web page in Firefox and scroll it up and down. Or open some other 
> window, move it around the screen on top of the Firefox window and see 
> how "fast" it really is. Then repeat the same in Windows.
> How can Xgl help here?

I wonder if firefox window gets redrawn when you scroll or move stuff over
it. I fondly remember GTK1 overdrawing the scrollbar with grey rectangles,
then putting the scrollbar pixmaps on top, repeated about 6 times, and this
all done a few times per second for a nice flickering effect on your scollbar..

Do the widget toolkits still only push pixels to the screen, or do they actually
take advantage of any acceleration features that X provides?
