Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262935AbSJGJXU>; Mon, 7 Oct 2002 05:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262942AbSJGJXU>; Mon, 7 Oct 2002 05:23:20 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:56850 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S262935AbSJGJXU>; Mon, 7 Oct 2002 05:23:20 -0400
Message-Id: <200210070923.g979NMp17804@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Hacksaw <hacksaw@hacksaw.org>, Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: LILO probs
Date: Mon, 7 Oct 2002 12:16:59 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200210070826.g978QRhq007655@habitrail.home.fools-errant.com>
In-Reply-To: <200210070826.g978QRhq007655@habitrail.home.fools-errant.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 October 2002 06:26, Hacksaw wrote:
> > > Disk /dev/hda: 16 heads, 63 sectors, 38792 cylinders
> > >
> > > Nr AF  Hd Sec  Cyl  Hd Sec  Cyl    Start     Size ID
> > >  1 80   1   1    0  15  63  609       63   614817 83
> > >  2 00   0   1  610  15  63 1023   614880 10486224 83
> > >  3 00  15  63 1023  15  63 1023 11101104  4194288 83
> > >  4 00  15  63 1023  15  63 1023 15295392 23806944 0f
> > >  5 00  15  63 1023  15  63 1023       63  2097585 83
> > >  6 00  15  63 1023  15  63 1023       63  1048257 83
> > >  7 00  15  63 1023  15  63 1023       63  1048257 82
> > >  8 00  15  63 1023  15  63 1023       63 19612593 83
>
> It's a very confusing table, but more importantly it seems to imply
> that /dev/hda{5,6,7,8} all start at cylinder 63, and end in a variety
> of places.

It's a sector offset, not a cylinder.
Also extended partition method of storing offsets is 'interesting' :-(
--
vda
