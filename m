Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268255AbUIWENw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268255AbUIWENw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268260AbUIWEMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:12:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:51922 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268259AbUIWEEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 00:04:47 -0400
Date: Wed, 22 Sep 2004 21:02:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: tabris <tabris@tabris.net>
Cc: linux-kernel@vger.kernel.org, bzolnier@elka.pw.edu.pl
Subject: Re: undecoded slave?
Message-Id: <20040922210240.1d048d3f.akpm@osdl.org>
In-Reply-To: <200409222357.39492.tabris@tabris.net>
References: <200409222357.39492.tabris@tabris.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tabris <tabris@tabris.net> wrote:
>
> Probing IDE interface ide3...
>  hdg: Maxtor 4D060H3, ATA DISK drive
>  hdh: Maxtor 4D060H3, ATA DISK drive
>  ide-probe: ignoring undecoded slave
> 
>  Booted 2.6.9-rc2-mm2, and I no longer have an hdh. the error above seems 
>  to be the only [stated] reason why.

Ok, thanks.  Presumably, reverting ide-probe.patch will get you going.

>  back on 2.6.8-rc1-mm1+idefix2 (lba48 FLUSH CACHE bug) for now.

What is idefix2??
