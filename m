Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbTHZPOC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbTHZPOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:14:02 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:8710 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261362AbTHZPN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:13:59 -0400
Date: Tue, 26 Aug 2003 12:22:52 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, Gustavo Niemeyer <niemeyer@conectiva.com>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: Re: 2.6.0-test4-mm1: wl3501_cs.c doesn't compile
Message-ID: <20030826152251.GI921@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
	Gustavo Niemeyer <niemeyer@conectiva.com>,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	linux-net@vger.kernel.org
References: <20030824171318.4acf1182.akpm@osdl.org> <20030825173007.GT7038@fs.tum.de> <20030825174627.GA1094@conectiva.com.br> <20030825182441.GF1094@conectiva.com.br> <20030825183948.GG1094@conectiva.com.br> <20030825220108.GW7038@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825220108.GW7038@fs.tum.de>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 26, 2003 at 12:01:08AM +0200, Adrian Bunk escreveu:
> It's attached.

Not needed as per what you said below :)

> I traced the problem down to the gcc version: The file compiles with
> gcc 3.3 but fails to compile with gcc 2.95.

I see, I'll fix this one, I had a problem with this in another source file,
IIRC. Die, gcc 2.95 die! :-)

- Arnaldo
