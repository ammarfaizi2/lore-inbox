Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267071AbSLKIgt>; Wed, 11 Dec 2002 03:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267076AbSLKIgt>; Wed, 11 Dec 2002 03:36:49 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:49163 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267071AbSLKIgr>; Wed, 11 Dec 2002 03:36:47 -0500
Message-Id: <200212110829.gBB8Tja05013@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Daniel Egger <degger@fhm.edu>, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
Date: Wed, 11 Dec 2002 11:19:23 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Joseph <jospehchan@yahoo.com.tw>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw> <20021210055215.GA9124@suse.de> <1039504941.30881.10.camel@sonja>
In-Reply-To: <1039504941.30881.10.camel@sonja>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 December 2002 05:22, Daniel Egger wrote:
> Am Die, 2002-12-10 um 06.52 schrieb Dave Jones:
> > I believe someone (Jeff Garzik?) benchmarked gcc code generation,
> > and the C3 executed code scheduled for a 486 faster than it did for
> > -m586
> > I'm not sure about the alignment flags. I've been meaning to look
> > into that myself...
>
> Interesting. I have no clue about which C3 you're talking about here
> but a VIA Ezra has all 686 instructions including cmov and thus
> optimising for PPro works best for me.
>
> Prolly I would have to do more benchmarking to find out about
> aligment advantages.

I heard cmovs are microcoded in Centaurs.

s...l...o...w...
--
vda
