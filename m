Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbUJZLob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbUJZLob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUJZLob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:44:31 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:57355 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261224AbUJZLo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:44:27 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: The naming wars continue...
Date: Tue, 26 Oct 2004 14:43:54 +0300
User-Agent: KMail/1.5.4
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <200410261032.34133.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.GSO.4.61.0410261311160.19019@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.61.0410261311160.19019@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410261442.11618.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > However, there is a tendency for numbers to get stuck (witness Linux
> > > 2.x).  In particular, X11R6 got encoded in many places including
> > > pathnames for no good reason.  Under the pre-R6 naming schemes we'd
> > > had R7 a long time ago.
> > 
> > How true.
> 
> > This should be removed.
> > 
> > cd /usr/lib; ln -s /usr/X11R6/* .
> > 	or
> > echo /usr/X11R6/lib >>/etc/ld.so.conf
> > 
> > are the better ways to handle this
> > (I use first one)
> 
> /usr/{bin,lib/X11 have been version-free symlinks since ages...

Why X server special cased at all?

Having /usr/XnnRmm was a mistake in the first place.
--
vda

