Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbUKXGkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbUKXGkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 01:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUKXGkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 01:40:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:48518 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261962AbUKXGkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 01:40:33 -0500
Date: Tue, 23 Nov 2004 22:40:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: mpm@selenic.com, colin@colino.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
Message-Id: <20041123224002.54a0e1e6.akpm@osdl.org>
In-Reply-To: <871xejvk3l.fsf@devron.myhome.or.jp>
References: <20041118194959.3f1a3c8e.colin@colino.net>
	<87653wxqij.fsf@devron.myhome.or.jp>
	<20041124032017.GG8040@waste.org>
	<87pt237se1.fsf@devron.myhome.or.jp>
	<20041124053552.GD2460@waste.org>
	<871xejvk3l.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> AFAIK, EXT2 doesn't update all metadata synchronously in sync-mode.

It does.

I'm actually surprised to discover that [v]fat doesn't support `-o sync'. 
It's probably a quite practical way of handling these various hotpluggable
gadgets and would be a popular addition.

It does have the downside that it'll teach our users bad practices....
