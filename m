Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWBFVdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWBFVdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 16:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWBFVdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 16:33:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9658 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932184AbWBFVdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 16:33:11 -0500
Date: Mon, 6 Feb 2006 13:32:34 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: khali@linux-fr.org, 76306.1226@compuserv.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [PATCH] stop ==== emergency
Message-Id: <20060206133234.1ca5d1ed.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0602062057570.4093@goblin.wat.veritas.com>
References: <mailman.1139006040.12873.linux-kernel2news@redhat.com>
	<20060205205709.0b88171b.zaitcev@redhat.com>
	<Pine.LNX.4.61.0602060841540.6574@goblin.wat.veritas.com>
	<20060206195504.16b60b93.khali@linux-fr.org>
	<Pine.LNX.4.61.0602062057570.4093@goblin.wat.veritas.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006 21:11:11 +0000 (GMT), Hugh Dickins <hugh@veritas.com> wrote:

> But my own interest in minimizing printk calls is rather low at the
> moment; and they're hardly time-critical, are they?

Absolutely, saving time by mering printks is rather stupid. That said,
I'm totally sick of "<4>" all over the place. You might not see it on
your VGA, but it leakes everywhere else and is annoying. As far as
I am concerned, every printk must end with a newline and this is why
I disagreed with your  printk(log_lvl);

-- Pete
