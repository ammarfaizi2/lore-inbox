Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTEPQYe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 12:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbTEPQYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 12:24:34 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11686
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264476AbTEPQYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 12:24:34 -0400
Subject: Re: 2.5.69-mm6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bert hubert <ahu@ds9a.nl>
Cc: Andrew Morton <akpm@digeo.com>, ch@murgatroid.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030516100432.GA21627@outpost.ds9a.nl>
References: <20030516015407.2768b570.akpm@digeo.com>
	 <20030516100432.GA21627@outpost.ds9a.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053099462.5599.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 May 2003 16:37:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-16 at 11:04, bert hubert wrote:
> Please don't! For the same reason as the futexes, turning this off will
> randombly break stuff and on a pc it won't give any benefit.
> 
> I'd vote for treating this patch just like the futexes one, making sure that
> those who know *how* can turn epoll off, but leave it out of make config.
> 
> Furthermore, I wonder if this patch is a large savings, the bulk of epoll is
> infrastructure, not the few syscalls.

All of this stuff should be disablable and far more. It probably all
wants hiding under a single "Shrink feature set" type option most people
can skip over as they do with kernel debugging.

