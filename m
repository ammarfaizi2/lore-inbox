Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314125AbSDLRxk>; Fri, 12 Apr 2002 13:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314129AbSDLRxj>; Fri, 12 Apr 2002 13:53:39 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:26884 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314125AbSDLRxj>; Fri, 12 Apr 2002 13:53:39 -0400
Message-Id: <200204121751.g3CHpBX15117@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Shawn Starr <shawn.starr@datawire.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic 2.4.19-pre6 AND 2.4.19-pre5-ac3
Date: Fri, 12 Apr 2002 20:54:23 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <1018560530.356.0.camel@unaropia> <1018618403.224.13.camel@unaropia>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 April 2002 11:33, Shawn Starr wrote:
> The same kernel panic is observed when using 2.4.19-pre6 or
> 2.4.19-pre5-ac3:

[snip]

> call trace:
> [<c01b6996>][<c01ae406>][<c01b5a79>][<c013f81a>][<c01b6013>][<c01b65cf>][<c
>01055000>[<c010506f>][<c0105000>][<c0107316>][<c0105050>]
>
> Code: 8b 40 20 c7 40 24 00 00 00 00 a1 a0 3e 2d c0 59 89 15 c4 cf

Run this thru ksymoops

======== Durning boot it stopped at:
>
> hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> <NEVER GOT TO THIS BELOW>
> ===========================
> Partition check:
>  hda: hda1 hda2 hda3 hda4
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> ===========================

I gather it used to reach "partition check" before.
With which kernel?
--
vda
