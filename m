Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbUKWIH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbUKWIH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 03:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbUKWIH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 03:07:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:47492 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262275AbUKWIHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 03:07:24 -0500
Date: Tue, 23 Nov 2004 00:06:43 -0800
From: Greg KH <greg@kroah.com>
To: Guillaume Thouvenin <Guillaume.Thouvenin@Bull.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.9] fork: add a hook in do_fork()
Message-ID: <20041123080643.GD23974@kroah.com>
References: <1101189797.6210.53.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101189797.6210.53.camel@frecb000711.frec.bull.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 07:03:17AM +0100, Guillaume Thouvenin wrote:
> 
>    I don't know if this solution is good but it's easy to implement and
> it just does the trick. I made some tests and it doesn't impact the
> performance of the Linux kernel. 

What's wrong with the LSM hook already available for you to use for this
function?

thanks,

greg k-h
