Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWBSROP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWBSROP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 12:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWBSROP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 12:14:15 -0500
Received: from mx1.suse.de ([195.135.220.2]:18629 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932158AbWBSROP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 12:14:15 -0500
From: Andi Kleen <ak@suse.de>
To: Brian Hall <brihall@pcisys.net>
Subject: Re: Help: DGE-560T not recognized by Linux
Date: Sun, 19 Feb 2006 18:13:58 +0100
User-Agent: KMail/1.8.2
Cc: Greg KH <greg@kroah.com>, shemminger@osdl.org, vsu@altlinux.ru,
       akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20060217222720.a08a2bc1.brihall@pcisys.net> <20060219010441.GA5810@kroah.com> <20060219092007.e7eb6c1b.brihall@pcisys.net>
In-Reply-To: <20060219092007.e7eb6c1b.brihall@pcisys.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602191813.59928.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 February 2006 17:20, Brian Hall wrote:
> On Sat, 18 Feb 2006 17:04:41 -0800
> Greg KH <greg@kroah.com> wrote:
> > On Sat, Feb 18, 2006 at 04:35:55PM -0800, Stephen Hemminger wrote:
> > > The problem can also be caused by buggy BIOS's that don't report
> > > proper values for mmconfig space. There is some code in mmconfig.c
> > > that tries to handle that. It might not handle what ever your
> > > system is reporting. Andi Kleen seems to be the last person
> > > involved and might be able to help.
> > > 
> > > It would be useful to add some printk's to mmconfig to dump out the
> > > table after it discovers the table.
> > 
> > Andi has a follow-on patch at:
> > 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-03-pci/pci-give-pci-config-access-initialization-a-defined-ordering.patch
> > that should take care of these kinds of mmconfig issues by ordering
> > the pci config accessors properly.
> > 
> > Can you test this patch out to see if it fixes this problem on your
> > machine?
> 
> I applied this patch to 2.6.15-ck4 and 2.6.14-rc4, in both cases the
> compilation fails the same way:

The patch is for 2.6.16-rc3, not 2.6.15 or earlier prehistory. In general
we only care about the latest kernels on these lists.

-Andi
