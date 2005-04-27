Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVD0U7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVD0U7i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 16:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbVD0U7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 16:59:30 -0400
Received: from karnickel.franken.de ([193.141.110.11]:12810 "EHLO
	karnickel.franken.de") by vger.kernel.org with ESMTP
	id S262012AbVD0U6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 16:58:54 -0400
Subject: Re: [04/07] partitions/msdos.c fix
From: Erik Tews <erik@debian.franken.de>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20050427203440.GA26759@apps.cwi.nl>
References: <20050427171446.GA3195@kroah.com>
	 <20050427171627.GE3195@kroah.com>  <20050427203440.GA26759@apps.cwi.nl>
Content-Type: text/plain
Date: Wed, 27 Apr 2005 22:49:28 +0200
Message-Id: <1114634968.18249.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 27.04.2005, 22:34 +0200 schrieb Andries Brouwer:
> On Wed, Apr 27, 2005 at 10:16:27AM -0700, Greg KH wrote:
> 
> > -stable review patch.  If anyone has any objections, please let us know.
> > 
> > ------------------
> > 
> > Erik reports this fixes an oops on boot for him.
> 
> No objections. But..
> 
> The purpose of this patch was not to fix an oops, but to avoid
> partition table parsing in a situation where almost surely
> no partition table is present.
> 
> If this fixes an oops, then I want to know precisely what oops.
> No doubt that same oops could occur in other circumstances where
> this patch does not happen to help.

Hi, this happend on my laptop (ibm thinkpad t41p, intel cpu, no special
kind of partition layout). Because this happend during partition table
parsing (during bootup), I was not able to copy it.

But this should only affect the first 512 bytes of my harddisk, or? If
so, I can copy this data and send it to you.

