Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269433AbUIYWtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269433AbUIYWtK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 18:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269437AbUIYWtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 18:49:10 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:49397 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269433AbUIYWtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 18:49:07 -0400
Message-ID: <5d6b657504092515493c5f73da@mail.gmail.com>
Date: Sun, 26 Sep 2004 00:49:07 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Stephan Dreyer <stephan.dreyer@t-online.de>
Subject: Re: Get ip before accept
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1CBJgr-2AiaYq0@fwd01.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1CBJgr-2AiaYq0@fwd01.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004 23:02:48 +0200, Stephan Dreyer
<stephan.dreyer@t-online.de> wrote:
> Hi
> I'm trying to get a client ip before calling accept
> Any ideas how?
> It should be possible to get ip from connection queue when switching to
> kernel space should it?
> If ip doesnt't match a given list i want to close the not fully established
> connection

Try netfilter/iptables:
http://www.netfilter.org/documentation/HOWTO//netfilter-hacking-HOWTO.html
 

Cheers,
Buddy
