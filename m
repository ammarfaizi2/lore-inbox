Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264618AbTFAN6n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 09:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264619AbTFAN6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 09:58:43 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31714
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264618AbTFAN6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 09:58:42 -0400
Subject: Re: Question about style when converting from K&R to ANSI C.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Steven Cole <elenstev@mesatop.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0306010242570.2614-100000@montezuma.mastecende.com>
References: <1054446976.19557.23.camel@spc>
	 <20030601063946.GF10719@conectiva.com.br>
	 <Pine.LNX.4.50.0306010242570.2614-100000@montezuma.mastecende.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054473242.5862.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2003 14:14:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-06-01 at 07:43, Zwane Mwaikambo wrote:
> --- linux-2.5/scripts/Lindent	31 May 2003 18:57:19 -0000	1.16
> +++ linux-2.5/scripts/Lindent	1 Jun 2003 05:46:02 -0000
> @@ -1,2 +1,2 @@
>  #!/bin/sh
> -indent -kr -i8 -ts8 -sob -l80 -ss -bs -psl "$@"
> +indent -kr -i8 -ts8 -sob -l80 -ss -bs "$@"

Take out the -l80 as well, it makes indent do horrific things to code,
and mangled 80 column wrapping is not the normal Linux style

