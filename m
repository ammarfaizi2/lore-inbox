Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUKWXw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUKWXw6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbUKWXug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:50:36 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:6418 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261638AbUKWXtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:49:12 -0500
Date: Wed, 24 Nov 2004 00:49:10 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org, mtk-manpages@gmx.net
Subject: Re: bug in man netdevice?
Message-ID: <20041123234910.GA3488@pclin040.win.tue.nl>
References: <20041123214320.GA2193@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123214320.GA2193@beton.cybernet.src>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 09:43:20PM +0000, Karel Kulhavy wrote:

> struct ifreq {
>            char    ifr_name[IFNAMSIZ];/* Interface name */
>            union {
>                    struct sockaddrifr_addr;
>                    struct sockaddrifr_dstaddr;
>                    struct sockaddrifr_broadaddr;
>                    struct sockaddrifr_netmask;
>                    struct sockaddrifr_hwaddr;
> 
> This looks like spaces forgotten between "sockaddr" and ifr_something.
> Is it a bug? Or is it some elaborate language construct?

This is not for l-k but for mtk-manpages@gmx.net .

And to answer your question, there is a tabs line in the source
that puts the tabs at the wrong positions. Do a
  1,$s/sockaddr<tab>/sockaddr /

Andries
