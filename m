Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTEFKir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 06:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTEFKir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 06:38:47 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:48550
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262524AbTEFKin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 06:38:43 -0400
Subject: Re: ISDN massive packet drops while DVD burn/verify
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Karsten Keil <kkeil@suse.de>, kai@tp1.ruhr-uni-bochum.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030505173249.50a72df9.skraw@ithnet.com>
References: <20030416151221.71d099ba.skraw@ithnet.com>
	 <Pine.LNX.4.44.0304161056430.5477-100000@chaos.physics.uiowa.edu>
	 <20030419193848.0811bd90.skraw@ithnet.com>
	 <1050789691.3955.17.camel@dhcp22.swansea.linux.org.uk>
	 <20030505142300.GC28010@pingi3.kke.suse.de>
	 <20030505173249.50a72df9.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052214757.28797.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 10:52:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-05 at 16:32, Stephan von Krawczynski wrote:
> Let me simply ask back: is the IDE code in nowadays 2.4 kernel so bad, that a
> dual 1,4 GHz PIII cpu with 3 GB ram performs much worse than a 90 MHz P I with
> 64 MB and OS/2 on it???
> _My_ isdn drivers showed _no_ such problems under OS/2 and IDE load...
> 
> How did we manage to become that bad?

Our default behaviour in PIO mode is defensive to handle very old controller setups
that chew up disks when the disk gets ahead of the pio transfer.

