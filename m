Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262592AbTDAPMy>; Tue, 1 Apr 2003 10:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262597AbTDAPMy>; Tue, 1 Apr 2003 10:12:54 -0500
Received: from mail.mtds.com ([194.204.200.6]:44946 "EHLO mail.mtds.com")
	by vger.kernel.org with ESMTP id <S262592AbTDAPMs> convert rfc822-to-8bit;
	Tue, 1 Apr 2003 10:12:48 -0500
Date: Tue, 1 Apr 2003 15:24:05 +0000
From: Simon White <simon@mtds.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Mikael Pettersson <mikpe@user.it.uu.se>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: New: SSE2 enabled by default on Celeron (P4 based)
Message-ID: <20030401152405.GA1780@mtds.com>
References: <17080000.1049207466@[10.10.2.4]> <16009.43013.754047.36875@gargle.gargle.HOWL> <20030401151640.GB28635@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030401151640.GB28635@suse.de>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.64
Content-Transfer-Encoding: 8BIT
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.10; VAE: 6.18.0.3; VDF: 6.18.0.20; host: vexira.mtds.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01-Apr-03 at 16:16, Dave Jones (davej@codemonkey.org.uk) wrote :
> On Tue, Apr 01, 2003 at 04:53:57PM +0200, Mikael Pettersson wrote:
> 
>  >  > Steps to reproduce: Compile kernel choosing *any* Celeron option
>  >  > 
>  >  > /proc/cpuinfo:-
>  >  > processor       : 0
>  >  > vendor_id       : GenuineIntel
>  >  > cpu family      : 6
>  >  > model           : 11
>  > 
>  > This is NOT a P4-based Celeron. It's a P6 Tualatin Celeron, and as such,
>  > it does not support SSE2.
>  > 
>  > This CPU needs a kernel configured for a Pentium III or less.
> 
> The *any* part of the bug report doesn't make much sense.
> That indicates that we're doing the wrong thing on the Pentium
> III/Celeron option too.

Sorry about that. I got confused - too late a night. I thought that all
the Celeron options set the SSE2 flag but looking at it again, they
don't. I have a memory of a compile for PIII/Celeron which kernel
panicked with "processor doesn't support SSE2" but I cannot reproduce
this. 

My apologies once again,

-- 
[--Partly Cloudy in Rabat, 19°C/66°F. Wind: W strength 12. Humidity: 73%-]
The only reason I'm burning my candle at both ends, is because I haven't
figured out how to light the middle yet.
[Linux user 170823|XML Weather:www.interceptvector.com|.sig:vim/mutt/perl]
