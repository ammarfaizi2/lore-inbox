Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbUK1AjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUK1AjG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 19:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbUK1AjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 19:39:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2001 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261380AbUK1AjD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 19:39:03 -0500
Date: Sun, 28 Nov 2004 00:39:01 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Problem with ioctl command TCGETS
Message-ID: <20041128003901.GS26051@parcelfarce.linux.theplanet.co.uk>
References: <20041128002044.CE13839877@uekae.uekae.gov.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128002044.CE13839877@uekae.uekae.gov.tr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 02:22:51AM +0200, Ozan Eren Bilgen wrote:
> 1. Is it nice to break _IO macros?

There is nothing nice about ioctls.

> 2. If it has a historical reason, shall I forget to trust to the
> informations that I decoded using _IO* macros?

You should.

> 3. Is there a list of such amazing commands?

There isn't.
