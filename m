Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbUK0Ch4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbUK0Ch4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUK0CFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:05:33 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262922AbUKZThz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:37:55 -0500
Subject: Re: [PATCH] Work around for periodic do_gettimeofday hang
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101397634.18177.17.camel@localhost.localdomain>
References: <1101314988.1714.194.camel@mulgrave> 
	<1101397634.18177.17.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 25 Nov 2004 11:33:53 -0600
Message-Id: <1101404039.1717.17.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-25 at 09:47, Alan Cox wrote:
> What are the other CPUs doing in this case ?

Actually, I don't know ... I can't seem to persuade the voyagers to
broadcast an NMI to give up that information.

However, unfortunately, I got a similar hang at HZ=100 this time not
implicating do_gettimeofday.

I'll continue investigating.

James


