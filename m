Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTEZNCb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 09:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbTEZNCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 09:02:31 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:37639 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264363AbTEZNC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 09:02:29 -0400
Date: Mon, 26 May 2003 10:15:28 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, ncorbic@sangoma.com, dm@sangoma.com
Subject: Re: 2.5.69-mm9: undefined references to `router_devlist'
Message-ID: <20030526131528.GA1178@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	ncorbic@sangoma.com, dm@sangoma.com
References: <20030525042759.6edacd62.akpm@digeo.com> <20030525205409.GF16791@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030525205409.GF16791@fs.tum.de>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My fault, will send a fix to DaveM shortly.

Em Sun, May 25, 2003 at 10:54:09PM +0200, Adrian Bunk escreveu:
> It seems the following link error comes from Linus' tree:
> 
> <--  snip  -->
> 
> ...
> 386/oprofile/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
> ...
> net/built-in.o(.text+0x10b278): In function `r_start':
> : undefined reference to `router_devlist'
> net/built-in.o(.text+0x10b321): In function `r_next':
