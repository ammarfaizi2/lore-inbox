Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267880AbTB1NeD>; Fri, 28 Feb 2003 08:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267881AbTB1NeD>; Fri, 28 Feb 2003 08:34:03 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26001
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267880AbTB1NeC> convert rfc822-to-8bit; Fri, 28 Feb 2003 08:34:02 -0500
Subject: Re: Promise PDC 20376
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: David Monniaux <David.Monniaux@ens.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xheao34vv.fsf@lakritspuck.e.kth.se>
References: <3E5ED648.5080509@ens.fr>
	 <1046438573.16599.11.camel@irongate.swansea.linux.org.uk>
	 <yw1xheao34vv.fsf@lakritspuck.e.kth.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1046443550.16598.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Feb 2003 14:45:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 13:35, Måns Rullgård wrote:
> As I suppose you already know, the 20375 driver acts like a scsi
> driver.  I ran it through objdump -d and got ~20000 instructions.  I
> doubt anyone would want to analyse that load, even if it were legal.

Its legal here but I suspect you would get further mapping the MMIO registers
and reading the contents then seeing which values make sense matched to which
normal IDE registers.

