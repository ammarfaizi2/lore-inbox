Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313927AbSEMOhF>; Mon, 13 May 2002 10:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313925AbSEMOhE>; Mon, 13 May 2002 10:37:04 -0400
Received: from internal-bristol33.naxs.com ([216.98.66.33]:51742 "HELO
	internal-bristol33.naxs.com") by vger.kernel.org with SMTP
	id <S313927AbSEMOhD>; Mon, 13 May 2002 10:37:03 -0400
Date: Mon, 13 May 2002 10:36:17 -0400
From: William Thompson <wt@electro-mechanical.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sg in 2.4.18
Message-ID: <20020513103617.B3879@coredump.electro-mechanical.com>
In-Reply-To: <20020513101050.A3879@coredump.electro-mechanical.com> <E177HCS-0005ZT-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is it possible to open sg more than once for multiple devices?
> > IE, cdrecord 2 cds at once.
> 
> Each cd writer will have its own /dev/sg* device so yes

Thanks, I was wondering as I remember that having one open would block
another.  I last tried it on a 2.2.13 kernel when trying to read 2 audio
discs which didn't work.
