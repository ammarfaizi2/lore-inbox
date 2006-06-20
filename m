Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWFTQBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWFTQBa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWFTQBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:01:30 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:4797 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1751367AbWFTQB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:01:29 -0400
Date: Tue, 20 Jun 2006 10:01:28 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Matt LaPlante <laplam@rpi.edu>
Cc: "'Roman Zippel'" <zippel@linux-m68k.org>,
       "'Linus Torvalds'" <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Unify CONFIG_LBD and CONFIG_LSF handling
Message-ID: <20060620160128.GL1630@parisc-linux.org>
References: <Pine.LNX.4.64.0606201742280.12900@scrub.home> <000601c69481$a9f86c40$fe01a8c0@cyberdogt42>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000601c69481$a9f86c40$fe01a8c0@cyberdogt42>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 11:53:24AM -0400, Matt LaPlante wrote:
> > How likely is it that someone who doesn't understand the question needs
> > this option? I think N is a safe answer here.
> 
> This is the impression I had as well.  Even if you disagree though, I was
> equally confused by the fact that if we say to answer Y as default, why is
> the kconfig default already N?

The *default* is N as that's the answer most people want.  The *safe*
answer is Y as it won't prevent you from getting access to your data.
Makes sense?
