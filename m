Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271812AbTHMW6M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 18:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271941AbTHMW6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 18:58:12 -0400
Received: from trolis.narbutas-ir-ko.lt ([213.197.143.58]:11954 "HELO
	trolis.narbutas-ir-ko.lt") by vger.kernel.org with SMTP
	id S271812AbTHMW6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 18:58:11 -0400
Date: Thu, 14 Aug 2003 01:58:02 +0300 (EEST)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
To: maney@pobox.com, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Maney <maney@two14.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
References: <20030812213645.GA1079@furrr.two14.net> <Pine.LNX.4.44.0308131155090.4279-100000@localhost.localdomain>
 <20030813181330.GA1122@furrr.two14.net>
In-Reply-To: <20030813181330.GA1122@furrr.two14.net>
X-Mailer: Mahogany 0.65.0 'Claire', compiled for Linux 2.4.18-rc4 i686
X-Qmail-Scanner-Message-ID: <106081549252728904@trolis.narbutas-ir-ko.lt>
Message-Id: <S271812AbTHMW6L/20030813225811Z+15085@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003 13:13:30 -0500 Martin Maney <maney@two14.net> wrote:

> At this point the outcome was pretty much a foregone conclusion, but
> yep, reverting to ".id" stopped the corruption for this test case.  As
> Alan said, it "fixed" it only because that incorrect test happens to
> force the driver to use the lower DMA speed.  I had been about to
> report on that when your request for the explicit test arrived, but in
> short it's that rc1 (and earlier) were disabling the "66" clock speed,
> while rc2 was, correctly, finding no reason not to enable it.  The real
> bug, be it hardware or software, is that enabling the higher speed
> causes the corruption.

Do you have the latest Promise BIOS? If not, does it still happen with
the latest one?

Regards,
Nerijus

