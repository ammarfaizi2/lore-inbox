Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUCABlM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 20:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbUCABlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 20:41:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:31695 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262080AbUCABlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 20:41:05 -0500
Date: Sun, 29 Feb 2004 17:41:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: greg@kroah.com, thoffman@arnor.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.4-rc1-mm1: multiple definitions of `debug'
Message-Id: <20040229174158.18f40784.akpm@osdl.org>
In-Reply-To: <20040301011012.GI13764@fs.tum.de>
References: <20040229140617.64645e80.akpm@osdl.org>
	<20040301011012.GI13764@fs.tum.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> The new drivers/usb/input/ati_remote.c driver thinks "debug" would be a
>  good name for a global variable...

heh, I'll send a fix to Greg, thanks.

The existing user is the debug trap entry point in entry.S.
