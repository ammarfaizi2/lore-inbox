Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTIPPag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbTIPPag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:30:36 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:21413 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261940AbTIPPae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:30:34 -0400
Subject: Re: experiences beyond 4 GB RAM with 2.4.22
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>, neilb@cse.unsw.edu.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030916172057.148a5741.skraw@ithnet.com>
References: <20030916102113.0f00d7e9.skraw@ithnet.com>
	 <Pine.LNX.4.44.0309161009460.1636-100000@logos.cnet>
	 <20030916153658.3081af6c.skraw@ithnet.com>
	 <1063722973.10037.65.camel@dhcp23.swansea.linux.org.uk>
	 <20030916172057.148a5741.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063726141.10036.130.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Tue, 16 Sep 2003 16:29:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel has no idea what you will do with given ram. It does try to
make some guesses but you are basically trying to paper over hardware
limits.

