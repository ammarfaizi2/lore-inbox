Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265417AbRF0Vcy>; Wed, 27 Jun 2001 17:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265421AbRF0Vck>; Wed, 27 Jun 2001 17:32:40 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:56072 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S265418AbRF0Vcb>;
	Wed, 27 Jun 2001 17:32:31 -0400
Message-ID: <3B3A50DE.C8A6C419@linux-m68k.org>
Date: Wed, 27 Jun 2001 23:32:14 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
CC: Jonathan Lundell <jlundell@pobox.com>,
        Mike Galbraith <mikeg@wen-online.de>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Paul.Russell@rustcorp.com.au
Subject: Re: [PATCH] proc_file_read() (Was: Re: proc_file_read() question)
In-Reply-To: <Pine.LNX.4.30.0106271919520.16282-100000@biker.pdb.fsc.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Martin Wilck wrote:

> Hum - is there no simple way to determine whether a pointer is
> a valid pointer to something returned by __get_free_pages ()? You are
> right, S390 in particular seems to allow arbitrary addresses starting from
> 0.

M68k does so too, although the first page is never used and usually
unmapped to catch NULL pointers.

bye, Roman
