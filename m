Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbUK0CLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbUK0CLw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbUK0CLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:11:44 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262745AbUKZThG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:37:06 -0500
Date: Thu, 25 Nov 2004 10:06:11 -0800
From: Greg KH <greg@kroah.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH] visor: Make URB limit error more visible
Message-ID: <20041125180611.GA30760@kroah.com>
References: <20041116154943.GA13874@k3.hellgate.ch> <20041119174405.GE20162@kroah.com> <20041123193604.GA12605@k3.hellgate.ch> <20041124232527.GB4394@kroah.com> <20041125161619.GD18567@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125161619.GD18567@k3.hellgate.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2004 at 05:16:19PM +0100, Roger Luethi wrote:
> There is only one call to dev_dbg in all of visor.c, the rest is dbg or
> dev_err. It already bit us once when warnings didn't turn up in a debug
> log. I would argue that a flood of those warnings will warrant report
> and inspection anyway (broken app, broken driver, or lame DoS attempt),
> so I replaced the dev_dbg with dev_err.
> 
> Signed-off-by: Roger Luethi <rl@hellgate.ch>

Thanks, but I already fixed this up in my trees yesterday.

greg k-h
