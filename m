Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264513AbRFYN2j>; Mon, 25 Jun 2001 09:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264511AbRFYN2a>; Mon, 25 Jun 2001 09:28:30 -0400
Received: from [213.22.80.107] ([213.22.80.107]:11531 "EHLO vega.net.dhis.org")
	by vger.kernel.org with ESMTP id <S264508AbRFYN2O>;
	Mon, 25 Jun 2001 09:28:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Claudio Martins <ctpm@vega.net.dhis.org>
To: Rodrigo Ventura <yoda@isr.ist.utl.pt>, linux-kernel@vger.kernel.org
Subject: Re: MemShared == 0 ?
Date: Mon, 25 Jun 2001 14:26:34 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <lx1yo86erg.fsf@pixie.isr.ist.utl.pt>
In-Reply-To: <lx1yo86erg.fsf@pixie.isr.ist.utl.pt>
MIME-Version: 1.0
Message-Id: <01062514263402.20445@vega>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday 25 June 2001 11:21, Rodrigo Ventura wrote:
> /proc> cat version meminfo
> Linux version 2.4.6-pre3 (yoda@damasio) (gcc version 2.95.2 19991024
> (release)) #3 Mon Jun 18 19:00:11 WEST 2001 total:    used:    free: 
> shared: buffers:  cached:
> Mem:  261779456 256925696  4853760        0 134025216 82280448
> Swap: 271425536 10993664 260431872     ^^^^
> MemTotal:       255644 kB                  \
> MemFree:          4740 kB                   \
> MemShared:           0 kB  <<<<<<<<<< **** What's the meaning of this?
> ***** Buffers:        130884 kB
>

  From the discussion I've read elsewhere in this list, it means that this 
value is just not computed anymore and is kept at 0 for compatibility with 
old programs that parse this table. It seems that presenting this number was 
computationaly expensive for the kernel.

regards
cumprimentos

  Claudio

