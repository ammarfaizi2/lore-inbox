Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263780AbRFCW4q>; Sun, 3 Jun 2001 18:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263799AbRFCW4g>; Sun, 3 Jun 2001 18:56:36 -0400
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:49728 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S263780AbRFCWK1>; Sun, 3 Jun 2001 18:10:27 -0400
Message-ID: <3B1AB5BA.8060805@humboldt.co.uk>
Date: Sun, 03 Jun 2001 23:10:02 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.8.1+) Gecko/20010502
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Lehmann <pcg@goof.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Axel Thimm <Axel.Thimm@physik.fu-berlin.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Au-Ja <doelf@au-ja.de>, Yiping Chen <YipingChen@via.com.tw>,
        support@msi.com.tw, info@msi-computer.de, support@via-cyrix.de,
        John R Lenton <john@grulic.org.ar>
Subject: Re: VIA's Southbridge bug: Latest (pseudo-)patch
In-Reply-To: <20010519110721.A1415@pua.nirvana> <20010601171848.F467@cerebro.laendle> <3B17B4B0.9A805766@mandrakesoft.com> <20010601221637.B13797@cerebro.laendle>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Lehmann wrote:


> Aren't PCI delayed transaction supposed to be handled by the pci master
> (e.g. my northbridge), not by the (software) driver for my pdc(?) I would
> also be surprised if my pdc actually used that feature, not to speak of
> the fact that the promise + harddisk worked fine in another computer (the
> data corruption was easily detectable, one couldn't even write 500megs
> without altered bytes).


Wrong way round. You're right that the pci master is supposed to handle 
delayed transactions, but during data transfer the pdc is the pci master 
and the northbridge is the PCI target.

-- 
Adrian Cox   http://www.humboldt.co.uk/

