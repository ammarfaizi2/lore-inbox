Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262776AbSIPTGf>; Mon, 16 Sep 2002 15:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSIPTGf>; Mon, 16 Sep 2002 15:06:35 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:58774 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262776AbSIPTGe>; Mon, 16 Sep 2002 15:06:34 -0400
Date: Mon, 16 Sep 2002 16:11:14 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Timothy D. Witham" <wookie@osdl.org>
cc: Helge Hafting <helgehaf@aitel.hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: Killing/balancing processes when overcommited
In-Reply-To: <1032202163.1458.351.camel@wookie-t23.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44L.0209161610370.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Sep 2002, Timothy D. Witham wrote:
> On Mon, 2002-09-16 at 07:03, Rik van Riel wrote:

> > > > 1) memory is exhausted
> > > > 2) the network driver can't allocate memory and
> > > >    spits out a message
> > > > 3) syslogd and/or klogd get killed

>   Not in what I had described.  Unless the page fault was for a new page
> (just malloc'ed) it wouldn't result in the killing of the process.

Unfortunately they do. Reality doesn't quite match your
description.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

