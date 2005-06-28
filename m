Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVF1U3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVF1U3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVF1U3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:29:05 -0400
Received: from smtpout.mac.com ([17.250.248.46]:10741 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261427AbVF1U2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:28:07 -0400
In-Reply-To: <20050628180157.GI12006@waste.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624123819.GD9519@64m.dyndns.org> <20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com>
Cc: Petr Baudis <pasky@ucw.cz>, Christopher Li <hg@chrisli.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Tue, 28 Jun 2005 16:27:53 -0400
To: Matt Mackall <mpm@selenic.com>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28, 2005, at 14:01:57, Matt Mackall wrote:
> Everything in Mercurial is an append-only log. A transaction journal
> records the original length of each log so that it can be restored on
> failure.

Does this mean that (excepting the "undo" feature) one could set the
ext3 "append-only" attribute on the repository files to avoid losing
data due to user account compromise?

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer

