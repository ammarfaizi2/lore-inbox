Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUKXG5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUKXG5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 01:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbUKXG5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 01:57:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:5266 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262085AbUKXG5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 01:57:49 -0500
Date: Tue, 23 Nov 2004 22:57:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: hirofumi@mail.parknet.co.jp, colin@colino.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
Message-Id: <20041123225727.59785df9.akpm@osdl.org>
In-Reply-To: <20041124064930.GE2460@waste.org>
References: <20041118194959.3f1a3c8e.colin@colino.net>
	<87653wxqij.fsf@devron.myhome.or.jp>
	<20041124032017.GG8040@waste.org>
	<87pt237se1.fsf@devron.myhome.or.jp>
	<20041124053552.GD2460@waste.org>
	<871xejvk3l.fsf@devron.myhome.or.jp>
	<20041123224002.54a0e1e6.akpm@osdl.org>
	<20041124064930.GE2460@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> > It does have the downside that it'll teach our users bad practices....
> 
> Dunno. Right now they'll still probably have an occassional kernel
> crash to contend with from device disappearing from under an fs, but
> at least they won't have lost all the photos on their camera...

Yes, but after a fisaco like that, they'll remember to type `umount'!

Maybe I wasn't cut out for a career as an educator.
