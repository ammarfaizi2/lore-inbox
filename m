Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263853AbTKLQpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 11:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTKLQpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 11:45:22 -0500
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:63981 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S263853AbTKLQpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 11:45:19 -0500
Subject: Re: 2.6 early userspace init
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Michael Schroeder <mls@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031112115021.GA24875@suse.de>
References: <20031112115021.GA24875@suse.de>
Content-Type: text/plain
Message-Id: <1068655518.14435.37.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 12 Nov 2003 08:45:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-12 at 03:50, Michael Schroeder wrote:

> how about adding something like this to init/do_mounts.c?

It's not a bad idea, but surely you should be using the init= boot
parameter instead of hard-coding a path.

In any case, I don't think you should expect a patch to be accepted. 
There's not much point in further crufting up do_mounts.c in generic
kernels during 2.6, until do_mounts moves completely out of the kernel. 
Some people are happy enough with root=0:0, so there's not obviously a
consensus about which stopgap measure will do for now.

	<b

