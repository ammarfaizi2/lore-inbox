Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136517AbREAOwH>; Tue, 1 May 2001 10:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136621AbREAOvr>; Tue, 1 May 2001 10:51:47 -0400
Received: from [64.64.109.142] ([64.64.109.142]:24071 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S136620AbREAOvm>; Tue, 1 May 2001 10:51:42 -0400
Message-ID: <3AEECD51.ABC493CB@didntduck.org>
Date: Tue, 01 May 2001 10:50:57 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: mike_phillips@urscorp.com, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
In-Reply-To: <E14ubFe-0001jg-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > a) change everything to read/write and friends (the way the driver used to
> > be before the isa_read/write function were introduced)
> 
> readb/readw/readl have always worked for ISA bus. They simply avoid the need
> for ioremap and are meant for lazy porting

You meant isa_read* were for lazy porting.  read* require ioremap be
done before hand, even for ISA.

--

				Brian Gerst
