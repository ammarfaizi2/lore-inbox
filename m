Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263138AbUEWPv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbUEWPv7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 11:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbUEWPv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 11:51:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50641 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263121AbUEWPv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 11:51:56 -0400
Date: Sun, 23 May 2004 11:51:33 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: 2.6.6-mm5
In-Reply-To: <1085219162.1628.3.camel@teapot.felipe-alfaro.com>
Message-ID: <Xine.LNX.4.44.0405231149280.1940-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2004, Felipe Alfaro Solana wrote:

> On Sat, 2004-05-22 at 10:36, Andrew Morton wrote:
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm5/
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm5/
> > 
> 
> Will you included the i586-optimized AES patch from Fruhwirth Clemens to
> the -mm tree? I find this patch really interesting, as it boost IPSec
> ESP AES considerably.

The problem is that we still need some kind of algorithm selection
mechanism (config time, preferrably), so that the right boxes get the asm
version loaded.


- James
-- 
James Morris
<jmorris@redhat.com>


