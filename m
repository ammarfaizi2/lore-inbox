Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWIKPNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWIKPNG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbWIKPNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:13:06 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:15568 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S964839AbWIKPNF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:13:05 -0400
Date: Mon, 11 Sep 2006 19:12:58 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Containers <containers@lists.osdl.org>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] vt: Make vt_pid a struct pid (making it pid wrap around safe).
Message-ID: <20060911151258.GA82@oleg>
References: <m1u03fevvz.fsf@ebiederm.dsl.xmission.com> <m1ac57as5y.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ac57as5y.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10, Eric W. Biederman wrote:
> 
> The patch:
> [PATCH] vt: Rework the console spawning variables.
> is fine.
> 
> The patch:
> [PATCH] vt: Make vt_pid a struct pid (making it pid wrap around safe).
> which uses xchg() is racy, and needs to be fixed.

Yes, I think so.

Oleg.

