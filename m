Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316834AbSEWPwp>; Thu, 23 May 2002 11:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316867AbSEWPwo>; Thu, 23 May 2002 11:52:44 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:30479 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316834AbSEWPwn>; Thu, 23 May 2002 11:52:43 -0400
Date: Thu, 23 May 2002 17:52:37 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: IDE problem: linux-2.5.17
Message-ID: <20020523155237.GB24260@louise.pinerecords.com>
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFC5B.3030701@evision-ventures.com> <20020523193959.A2613@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.2.21 SMP
X-Architecture: sparc
X-Uptime: 19:02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If that's a bad cable, why it is only happens when both drives are working
> in DMA mode?

Because, as you probably know, cable problems usually manifest themselves
during high transfer rates, where DMA is the prerequisite. Up to ATA33, you
might nearly hook your drives up using a shoelace w/o running into trouble,
ATA66+, however, seems to be very sensitive to good cabling.

How about trying out what Andre Hedrick's convert.10 has to say about your
setup if you're convinced the cable is ok?

T.

Sidenote: I'd recommend putting the two drives on separate channels, you're
losing quite a bit of performance this way when doing hda<->hdb transfers.
