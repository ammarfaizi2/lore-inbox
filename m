Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTKXJUH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 04:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbTKXJUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 04:20:07 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:2616 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263692AbTKXJUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 04:20:05 -0500
Date: Mon, 24 Nov 2003 04:19:39 -0500
From: Alan Cox <alan@redhat.com>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: modular IDE in 2.4.23
Message-ID: <20031124091939.GC18057@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0311232221080.1292-100000@logos.cnet> <200311240150.37065.arekm@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311240150.37065.arekm@pld-linux.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also probably most of #includes from ide-probe-mini.c could be removed, too.
> 
> ps. is there some magic way to avoid need of extern int ideprobe_init_module(void); etc
> in ide-probe-mini.c?

Other than pushing them into a header file, not really. 


Looks good.

