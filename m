Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbULTQVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbULTQVb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 11:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbULTQVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 11:21:31 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:34797 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261561AbULTQVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 11:21:25 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ben Collins <bcollins@debian.org>
Cc: Arne Caspari <arnem@informatik.uni-bremen.de>,
       Adrian Bunk <bunk@stusta.de>, linux1394-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041220143901.GD457@phunnypharm.org>
References: <20041220015320.GO21288@stusta.de>
	 <41C694E0.8010609@informatik.uni-bremen.de>
	 <20041220143901.GD457@phunnypharm.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103555716.29968.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Dec 2004 15:15:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-20 at 14:39, Ben Collins wrote:
> How about adding those exports into an config option ifdef that says
> "Export extra IEEE-1394 symbols" and in the help explains that the symbols
> may be needed for some third party modules. Give video-2-1394 as an
> example.

You might as well remove the ifdef if you do that since vendors will
have to guess what the right answer is an will probably uniformly say
"Y". At that point its basically a non-option. Far better to submit the
driver

