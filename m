Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbTCMXXr>; Thu, 13 Mar 2003 18:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbTCMXXr>; Thu, 13 Mar 2003 18:23:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48336
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263215AbTCMXXq>; Thu, 13 Mar 2003 18:23:46 -0500
Subject: Re: Now i2o_core.c memleak/incorrectness?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030313193829.GA2940@linuxhacker.ru>
References: <20030313182819.GA2213@linuxhacker.ru>
	 <1047584663.25948.75.camel@irongate.swansea.linux.org.uk>
	 <20030313193829.GA2940@linuxhacker.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047602575.27471.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Mar 2003 00:42:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-13 at 19:38, Oleg Drokin wrote:
> Well, it seems that i2o does not always follow this rule.
> Also i2o_init_outbound_q() seems not free this "status" thing if everything
> went ok, is this intentional?
> Or perhaps something like this patch is needed?

I'll take a look. I'm doing a bunch of i2o cleanup in 2.5 right now

