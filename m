Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268937AbUIXSp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268937AbUIXSp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 14:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269080AbUIXSp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 14:45:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29092 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268937AbUIXSpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 14:45:42 -0400
Date: Fri, 24 Sep 2004 14:45:09 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.9-rc2-mm3 (tty deadlock?)
In-Reply-To: <Xine.LNX.4.44.0409241210220.8009-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0409241443510.8732-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, James Morris wrote:

> > to the serial/tty code?
> 
> Backing these out lets me boot again:
> 
> +tty-driver-take-4-try-2.patch
> +tty-locking-build-fix.patch

Another data point: everyone I've heard of so far with this problem is 
using serial console.


- James
-- 
James Morris
<jmorris@redhat.com>


