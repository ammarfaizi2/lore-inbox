Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVGZD3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVGZD3S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 23:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVGZD3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 23:29:17 -0400
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:29841 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261619AbVGZD3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 23:29:08 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Date: Mon, 25 Jul 2005 22:29:00 -0500
User-Agent: KMail/1.8.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <9e47339105072421095af5d37a@mail.gmail.com> <20050726015401.GA25015@kroah.com> <9e473391050725201553f3e8be@mail.gmail.com>
In-Reply-To: <9e473391050725201553f3e8be@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507252229.01360.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 July 2005 22:15, Jon Smirl wrote:
> +	while( isspace(*x) && (x - buffer->page < count))
> +		x++;
> +
> +	/* locate trailng white space */
> +	z = y = x;
> +	while (y - buffer->page < count) {
> +		y++;
> +		z = y;
> +		while( isspace(*y) && (y - buffer->page < count)) {
> +			y++;

Can we have consistent space vs. paren placement, pretty please?

-- 
Dmitry
