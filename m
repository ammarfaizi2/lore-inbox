Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265201AbUF1U2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUF1U2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 16:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUF1U2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 16:28:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:12242 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265201AbUF1U2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:28:04 -0400
Date: Mon, 28 Jun 2004 13:27:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Picco <Robert.Picco@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hpet related
Message-Id: <20040628132704.50874705.akpm@osdl.org>
In-Reply-To: <40E05EC2.20700@hp.com>
References: <40E05EC2.20700@hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Picco <Robert.Picco@hp.com> wrote:
>
> +static inline void hpet_timer_reserved(struct hpet_data *hd, int timer)
>  +{
>  +	hd->hd_state |= (1 << timer);
>  +	return;
>  +}

The identifier "hpet_timer_reserved" implies (to me) that the function
queries something.  Except it doesn't.

Would "hpet_reserve_timer" be a better choice?
