Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264708AbTFATHf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 15:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbTFATHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 15:07:35 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:37248
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264708AbTFATHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 15:07:33 -0400
Date: Sun, 1 Jun 2003 15:10:25 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Steven Cole <elenstev@mesatop.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question about style when converting from K&R to ANSI C.
In-Reply-To: <1054473242.5862.2.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.50.0306011509430.19313-100000@montezuma.mastecende.com>
References: <1054446976.19557.23.camel@spc>  <20030601063946.GF10719@conectiva.com.br>
  <Pine.LNX.4.50.0306010242570.2614-100000@montezuma.mastecende.com>
 <1054473242.5862.2.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jun 2003, Alan Cox wrote:

> On Sul, 2003-06-01 at 07:43, Zwane Mwaikambo wrote:
> > --- linux-2.5/scripts/Lindent	31 May 2003 18:57:19 -0000	1.16
> > +++ linux-2.5/scripts/Lindent	1 Jun 2003 05:46:02 -0000
> > @@ -1,2 +1,2 @@
> >  #!/bin/sh
> > -indent -kr -i8 -ts8 -sob -l80 -ss -bs -psl "$@"
> > +indent -kr -i8 -ts8 -sob -l80 -ss -bs "$@"
> 
> Take out the -l80 as well, it makes indent do horrific things to code,
> and mangled 80 column wrapping is not the normal Linux style

It shan't be missed ;)

Index: linux-2.5/scripts/Lindent
===================================================================
RCS file: /home/cvs/linux-2.5/scripts/Lindent,v
retrieving revision 1.16
diff -u -p -B -r1.16 Lindent
--- linux-2.5/scripts/Lindent	31 May 2003 18:57:19 -0000	1.16
+++ linux-2.5/scripts/Lindent	1 Jun 2003 18:12:43 -0000
@@ -1,2 +1,2 @@
 #!/bin/sh
-indent -kr -i8 -ts8 -sob -l80 -ss -bs -psl "$@"
+indent -kr -i8 -ts8 -sob -ss -bs "$@"

-- 
function.linuxpower.ca
