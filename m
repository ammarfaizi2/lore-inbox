Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268865AbSIRTcD>; Wed, 18 Sep 2002 15:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268361AbSIRTcC>; Wed, 18 Sep 2002 15:32:02 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:43532 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id <S268865AbSIRTcC>;
	Wed, 18 Sep 2002 15:32:02 -0400
To: Olaf =?iso-8859-1?q?Fr=B1czyk?= <olaf@cbk.poznan.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which processor/board for embedded NTP
References: <1032354632.23252.14.camel@venus>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 18 Sep 2002 21:37:02 +0200
In-Reply-To: <1032354632.23252.14.camel@venus>
Message-ID: <87r8frqech.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Fr±czyk <olaf@cbk.poznan.pl> writes:

> I have to build NTP server on an embedded pc.
> Which processors/boards are suitable for this.
> Such processor/board cannot have ANY problems with time handling.
> I thought about Geode (NS), but I found some info that it doesn't have
> TSC, or it works not properly (the PPS needs TSC). 
> And of course has to work excellent with linux.

The Geode's TSC will work quite well for you if you disable the
suspend on HLT option in the processor.

On the newer "IA on a chip" geodes (SC1200, SC2200 and SC3200) there
is also a high speed timer in the chipset that seems to be quite
stable.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
