Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbUK2ScW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbUK2ScW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 13:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbUK2ScV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 13:32:21 -0500
Received: from hera.kernel.org ([63.209.29.2]:44501 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261480AbUK2ScL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:32:11 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: 2.6.9 tcp problems
Date: Mon, 29 Nov 2004 10:35:48 -0800
Organization: Open Source Development Lab
Message-ID: <20041129103548.7b9a9e23@zqx3.pdx.osdl.net>
References: <41AB6476.8060405@nea-fast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1101753127 18078 172.20.1.73 (29 Nov 2004 18:32:07 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 29 Nov 2004 18:32:07 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-suse-linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004 13:03:34 -0500
kernel <kernel@nea-fast.com> wrote:

> I've run into a problem with 2.6.(8.1,9) after installing a secondary 
> firewall. When I try to pull data through the original firewall (mail, 
> http, ssh), it stops after approx. 260k. Running ethereal tells me "A 
> segment before the frame was lost" followed by a bunch of  "This is a 
> TCP duplicate ack" when using ssh. All 2.4.x machines and windows 
> clients work fine. I built 2.4.28 and it works fine from my machine. I 
> also fiddled with tcp_ecn and that didn't fix it either. I don't have 
> any problems communicating to "local" machines. I've attached the 
> tcpdump output from an scp attempt. NIC is a 3Com Corporation 3c905B.

What kind of firewall?  There are firewalls that are too stupid and don't
understand TCP window scaling.
