Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVC2CFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVC2CFi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 21:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVC2CFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 21:05:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:33709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262147AbVC2CFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 21:05:33 -0500
Date: Mon, 28 Mar 2005 18:05:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, christoph@lameter.com,
       kenneth.w.chen@intel.com
Subject: Re: [PATCH rc1-mm3] timers: simplify locking
Message-Id: <20050328180502.4ddd9855.akpm@osdl.org>
In-Reply-To: <424835D5.99FDB1D5@tv-sign.ru>
References: <424835D5.99FDB1D5@tv-sign.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> This is the last one, I promise.
>  On top of "[PATCH rc1-mm3] timers: kill timer_list->lock", see
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=111193319932543

I thought that earlier patch was a bit weird and I think it would be better
to get to the bottom of these problems which people have been reporting in
the 2.6.12-rc1-mm3 timer code before adding more things, don't you?

