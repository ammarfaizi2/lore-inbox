Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTFAGkg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 02:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTFAGkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 02:40:36 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:45441
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261352AbTFAGkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 02:40:35 -0400
Date: Sun, 1 Jun 2003 02:43:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Steven Cole <elenstev@mesatop.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question about style when converting from K&R to ANSI C.
In-Reply-To: <20030601063946.GF10719@conectiva.com.br>
Message-ID: <Pine.LNX.4.50.0306010242570.2614-100000@montezuma.mastecende.com>
References: <1054446976.19557.23.camel@spc> <20030601063946.GF10719@conectiva.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jun 2003, Arnaldo Carvalho de Melo wrote:

> > The above should be straightforward, but if there are any problems with
> > that, please holler.  I'll be sending patches through the maintainers
> > soon.
> 
> Perfect!

Why not just do this then;

Index: linux-2.5/scripts/Lindent
===================================================================
RCS file: /home/cvs/linux-2.5/scripts/Lindent,v
retrieving revision 1.16
diff -u -p -B -r1.16 Lindent
--- linux-2.5/scripts/Lindent	31 May 2003 18:57:19 -0000	1.16
+++ linux-2.5/scripts/Lindent	1 Jun 2003 05:46:02 -0000
@@ -1,2 +1,2 @@
 #!/bin/sh
-indent -kr -i8 -ts8 -sob -l80 -ss -bs -psl "$@"
+indent -kr -i8 -ts8 -sob -l80 -ss -bs "$@"

-- 
function.linuxpower.ca
