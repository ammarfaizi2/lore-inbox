Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbWI2AR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbWI2AR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWI2AR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:17:26 -0400
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:55463 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S965051AbWI2ARZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:17:25 -0400
From: Luke-Jr <luke@dashjr.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Mark Knecht" <markknecht@gmail.com>
Subject: Re: PCI bridge missing
Date: Fri, 29 Sep 2006 00:17:32 +0000
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200609281624.16082.luke@dashjr.org> <1159485255.13029.7.camel@localhost.localdomain>
In-Reply-To: <1159485255.13029.7.camel@localhost.localdomain>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke@dashjr.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609290017.34412.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 September 2006 21:39, you wrote:
>    Anyway, maybe you haven't cold booted the machine and could try that?

It's been cold-booted a few times, though I can't guarantee that for each 
kernel I tried.

On Thursday 28 September 2006 23:14, Alan Cox wrote: 
> Ar Iau, 2006-09-28 am 16:24 -0500, ysgrifennodd Luke-Jr:
> > However, this bridge is completely ignored and unseen by Linux. It does
> > not show up in lspci or dmesg (as far as I can tell) at all. The
> > daughterboard is plugged in, and the PCI cards on it are powered.
>
> lspci -vvxxx would be interesting

Will do tomorrow.

> Linux on PC assumes the BIOS did the work needed 

pci=nobios doesn't bypass that assumption? (I tried that too)

> so if there is some custom "enabler" driver in the Windows for it that might
> explain problems.

Some old Debian (2.2) manual at least implied it worked at one point. That's 
where I compared the lspci from. So this would be a regression, a hardware 
failure, or a misconfiguration.
