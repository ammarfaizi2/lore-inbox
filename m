Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268379AbUIGScj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268379AbUIGScj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268356AbUIGSbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:31:55 -0400
Received: from the-village.bc.nu ([81.2.110.252]:37797 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268379AbUIGS2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:28:48 -0400
Subject: Re: [PATCH] remove wake_up_all_sync
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040907180538.GA12434@lst.de>
References: <20040907151154.GB9577@lst.de>
	 <1094576397.9607.0.camel@localhost.localdomain>
	 <20040907180538.GA12434@lst.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094577989.9607.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 18:26:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-07 at 19:05, Christoph Hellwig wrote:
> The sync wakeups are an absolutely special case, we're only using them
> in the pipe code on __wake_up_parent.  If you think it's a logical part
> of the API were would you want to use it for?

Fair comment on grepping and more digging - objection dropped

