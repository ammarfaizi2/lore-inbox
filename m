Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWDXBKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWDXBKz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 21:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWDXBKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 21:10:54 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:3566 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1750841AbWDXBKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 21:10:54 -0400
Date: Mon, 24 Apr 2006 10:10:53 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: sekharan@us.ibm.com
Cc: akpm@osdl.org, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, " Valerie.Clement"@bull.net
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
In-Reply-To: <1145683725.21231.15.camel@linuxchandra>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
	<1145630992.3373.6.camel@localhost.localdomain>
	<1145638722.14804.0.camel@linuxchandra>
	<20060421155727.4212c41c.akpm@osdl.org>
	<1145670536.15389.132.camel@linuxchandra>
	<20060421191340.0b218c81.akpm@osdl.org>
	<1145683725.21231.15.camel@linuxchandra>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060424011053.B89707402F@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2006 22:28:45 -0700
Chandra Seetharaman <sekharan@us.ibm.com> wrote:

> > > pzone based memory controller:
> > > http://marc.theaimsgroup.com/?l=ckrm-tech&m=113867467006531&w=2
> > 
> > From a super-quick scan that looks saner.  Is it effective?  Is this the
> > way you're planning on proceeding?
> 
> Yes, it is effective, and the reclamation is O(1) too. It has couple of
> problems by design, (1) doesn't handle shared pages and (2) doesn't
> provide support for both min_shares and max_shares.

Right.  I wanted to show proof-of-cencept of the pzone based controller
and implemented minimal features necessary as the memory controller.
So, the pzone based controller still needs development and some cleanup.
