Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288178AbSACDlW>; Wed, 2 Jan 2002 22:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288176AbSACDlK>; Wed, 2 Jan 2002 22:41:10 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:45782 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S288173AbSACDkx>; Wed, 2 Jan 2002 22:40:53 -0500
Message-ID: <3C33D1B0.4DFDF76E@didntduck.org>
Date: Wed, 02 Jan 2002 22:36:16 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102220333.A26713@thyrsus.com> <Pine.LNX.4.33.0201030420160.6449-100000@Appserv.suse.de> <20020102221845.A27252@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Dave Jones <davej@suse.de>:
> > Go down the DMI path, and get it right _sometimes_, or take a zero.
> > Getting it right sometimes is likely to do more harm than good.
> 
> Not in this case.  If the DMI read fails, the worst-case result is the
> user sees some ISA extra questions.

No, the worst case is if the DMI read says no ISA slots when there
really are some, and the user misses a driver that he needs.

-- 

						Brian Gerst
