Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUC3JUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbUC3JUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:20:30 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:23001 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263555AbUC3JU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:20:29 -0500
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.5-rc2-mm5
Date: Tue, 30 Mar 2004 11:27:35 +0200
User-Agent: KMail/1.5
References: <20040329014525.29a09cc6.akpm@osdl.org>
In-Reply-To: <20040329014525.29a09cc6.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403301127.35263.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 of March 2004 11:45, Andrew Morton wrote:
>
> +remove-down_tty_sem.patch
> +tty-locking-again.patch
>

These two patches break things quite a bit for me.  With them, the kernel is 
unable to open any tty (virtual console, pts, whatever), it seems (my system 
is a dual AMD64 w/ NUMA w/o kernel preemption).

-- 
Rafael J. Wysocki,
SiSK
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
