Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUIUFoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUIUFoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 01:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267313AbUIUFoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 01:44:10 -0400
Received: from [217.111.56.18] ([217.111.56.18]:61826 "EHLO spring.sncag.com")
	by vger.kernel.org with ESMTP id S267312AbUIUFoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 01:44:09 -0400
To: Rainer Weikusat <rweikusat@sncag.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Implementation defined behaviour in read_write.c
In-Reply-To: <878yb5ey11.fsf@farside.sncag.com> (Rainer Weikusat's message
 of "Mon, 20 Sep 2004 23:54:34 +0800")
References: <878yb5ey11.fsf@farside.sncag.com>
From: Rainer Weikusat <rainer.weikusat@sncag.com>
Date: Tue, 21 Sep 2004 13:43:51 +0800
Message-ID: <874qlsfa7c.fsf@farside.sncag.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rainer Weikusat <rweikusat@sncag.com> writes:
> +	if (tot_len != cur_len) goto out;

... and this is of course rubbish ... both tests (ie <0 and !=)
