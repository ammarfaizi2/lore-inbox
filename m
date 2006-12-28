Return-Path: <linux-kernel-owner+w=401wt.eu-S1754972AbWL1Uq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972AbWL1Uq6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 15:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754971AbWL1Uq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 15:46:58 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58771 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753748AbWL1Uq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 15:46:57 -0500
Date: Thu, 28 Dec 2006 12:46:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
Message-Id: <20061228124644.4e1ed32b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006 21:27:40 +0100 (CET)
Tim Schmielau <tim@physik3.uni-rostock.de> wrote:

> After Al Viro (finally) succeeded in removing the sched.h #include in 
> module.h recently, it makes sense again to remove other superfluous 
> sched.h includes.

Why are they "superfluous"?  Because those compilation
units pick up sched.h indirectly, via other includes?

If so, is that a thing we want to do?
