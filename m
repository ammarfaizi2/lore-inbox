Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267274AbTBDMzh>; Tue, 4 Feb 2003 07:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTBDMzh>; Tue, 4 Feb 2003 07:55:37 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:30908 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S267274AbTBDMzg> convert rfc822-to-8bit; Tue, 4 Feb 2003 07:55:36 -0500
Date: Tue, 4 Feb 2003 14:04:38 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] use 64 bit jiffies
In-Reply-To: <20030204092936.GA14495@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.33.0302041401010.1267-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2003, [iso-8859-1] Jörn Engel wrote:

> On Tue, 4 February 2003 08:41:13 +0200, Denis Vlasenko wrote:
> >
> > 		Jiffy Wrap Bugs
> >
> > There is a better solution to ensure correct jiffy wrap handling in
> > *ALL* kernel code: make jiffy wrap in first five minutes of uptime.
> > Tim has a patch for such config option. This is almost right.
>
> This sounds very interesting. Is this patch availlable somewhere? If
> not, could you send a copy to me, Tim?

A patch for 2.4.20-pre7 (and maybe later) is at
  http://www.physik3.uni-rostock.de/tim/kernel/2.4/

I still need to forward port it to 2.5 (which should be easy).

Tim

