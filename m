Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752096AbWCGIX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbWCGIX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 03:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbWCGIX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 03:23:26 -0500
Received: from c-68-35-68-128.hsd1.nm.comcast.net ([68.35.68.128]:25028 "EHLO
	deneb.dwf.com") by vger.kernel.org with ESMTP id S1752096AbWCGIX0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 03:23:26 -0500
Message-Id: <200603070823.k278NE9o006674@deneb.dwf.com>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
To: Lee Revell <rlrevell@joe-job.com>
cc: Reg Clemens <reg@dwf.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, reg@deneb.dwf.com
Subject: Re: vmlinuz-2.6.16-rc5-git8 still nogo with Intel D945 Motherboard 
In-reply-to: <1141703317.25487.142.camel@mindpipe> 
References: <200603070340.k273ev0A003594@deneb.dwf.com> 
 <1141703317.25487.142.camel@mindpipe>
Comments: In-reply-to Lee Revell <rlrevell@joe-job.com>
   message dated "Mon, 06 Mar 2006 22:48:36 -0500."
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Mar 2006 01:23:14 -0700
From: Reg Clemens <reg@dwf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2006-03-06 at 20:40 -0700, Reg Clemens wrote:
> > 
> > Anyone working this problem? 
> 
> Why don't you try to narrow it down some?
> 

For what its worth, this is a D945GNT
It has ICH7 series Video/Sound/Ethernet on board.
The Video works in vesa mode, but not in native mode.
The sound is not recognized.
The ethernet is recognized by some kernels, but does not work.
It has ATA and SATA which both work.

My sound card is a Nvidia 6600, it works fine with 2.6.11.

At the moment I run with a 2.6.11 kernel, an ethernet card and a Soundblaster.
Other than the Onboard hardware not being supported, things work with the
2.6.11 kernel.  this PCI error only occurs with later kernels.

I could play halfsies to determine just when the PCI error starts, but
another responder had noted that he had similar problems after some
'large PCI changes'  (Im sure he mentioned what version they occurred
in, but it would take some searching to find his e-mail)

-- 
                                        Reg.Clemens
                                        reg@dwf.com


