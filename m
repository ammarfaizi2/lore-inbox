Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbTILVho (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTILVhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:37:43 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:60847 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261531AbTILVhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:37:42 -0400
Date: Fri, 12 Sep 2003 23:37:35 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Breno <brenosp@brasilsec.com.br>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Stack size
Message-ID: <20030912213735.GA11952@wohnheim.fh-wedel.de>
References: <004801c390bd$55cca700$f8e4a7c8@bsb.virtua.com.br> <20030912104114.B21503@build.pdx.osdl.net> <000f01c3795b$03b22fe0$980210ac@forumci.com.br> <20030912121119.C21503@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030912121119.C21503@build.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 September 2003 12:11:19 -0700, Chris Wright wrote:
> 
> * Breno (brenosp@brasilsec.com.br) wrote:
> > Is there a test in kernel to know how much memory is consumed by stack ?
> 
> Have you looked at the CONFIG_DEBUG_STACKOVERFLOW code?

Just a band aid, not more.  If you want to be sure, poison the stack
on fork and check the poison on exit.

Jörn

-- 
Do not stop an army on its way home.
-- Sun Tzu
