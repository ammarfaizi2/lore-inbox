Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267435AbUI0XIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267435AbUI0XIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 19:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267424AbUI0XIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 19:08:18 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:34446 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267435AbUI0XHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 19:07:22 -0400
Message-ID: <35fb2e5904092716077e744882@mail.gmail.com>
Date: Tue, 28 Sep 2004 00:07:19 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, jonathan@jonmasters.org,
       Lars Marowsky-Bree <lmb@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Thomas Habets <thomas@habets.pp.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
In-Reply-To: <20040927171253.GA9728@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200409230123.30858.thomas@habets.pp.se>
	 <20040923234520.GA7303@pclin040.win.tue.nl>
	 <1096031971.9791.26.camel@localhost.localdomain>
	 <200409242158.40054.thomas@habets.pp.se>
	 <1096060549.10797.10.camel@localhost.localdomain>
	 <20040927104120.GA30364@logos.cnet>
	 <20040927125441.GG3934@marowsky-bree.de>
	 <35fb2e590409270612524c5fb9@mail.gmail.com>
	 <20040927133554.GD30956@logos.cnet>
	 <20040927171253.GA9728@MAIL.13thfloor.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2004 19:12:53 +0200, Herbert Poetzl <herbert@13thfloor.at> wrote:

> I'm no friend of the 'extend swap idea' so don't
> get me wrong, but userspace can just reduce the
> cases where you get out-of-swap, without support
> from the kernel side (via some userspace helper)

I was just thinking it might be a suitable approach for some of the
distros to take when running on a machine with plenty of disk that for
whatever reason runs at risk of rolling over and dying - better to
take up some additional disk space than to have some critical server
process killed. It's not pretty but then neither is the oom killer,
and this might reduce some of that pain.

Jon.
