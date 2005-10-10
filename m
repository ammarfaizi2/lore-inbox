Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbVJJVTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVJJVTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 17:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbVJJVTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 17:19:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14537 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751248AbVJJVTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 17:19:41 -0400
Date: Mon, 10 Oct 2005 14:19:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: Clem Taylor <clem.taylor@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mq_open() fails with ENOMEM for 'large' message sizes?
Message-ID: <20051010211921.GO7991@shell0.pdx.osdl.net>
References: <ecb4efd10510101351q7264f104gdfd1b03085b42062@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb4efd10510101351q7264f104gdfd1b03085b42062@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Clem Taylor (clem.taylor@gmail.com) wrote:
> Any ideas where this limit is coming from?

You're probably being clamped by the rlimit.  Default is 800k (ulimit -q).

thanks,
-chris
