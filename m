Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbTILQNx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 12:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbTILQMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 12:12:32 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:27406 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261749AbTILQM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 12:12:28 -0400
Date: Fri, 12 Sep 2003 13:14:04 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Simon Kelley <simon@thekelleys.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: atmel: alignment problems in parisc64
Message-ID: <20030912161404.GC8713@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Simon Kelley <simon@thekelleys.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latest 2.6.0-test5 bk tree, but I have been seeing this for quite a while.

CC [M]  drivers/net/wireless/atmel.o
{standard input}: Assembler messages:
{standard input}:7785: Error: Field not properly aligned [8] (5108).
{standard input}:7785: Error: Invalid operands
make[3]: *** [drivers/net/wireless/atmel.o] Error 1
make[2]: *** [drivers/net/wireless] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

This is in the atmel_management_frame function

- Arnaldo
