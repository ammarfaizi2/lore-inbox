Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbUKJXx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbUKJXx2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 18:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbUKJXx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 18:53:27 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:42199 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S262066AbUKJXxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 18:53:21 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6.10-rc1-mm4: USB storage not working on AMD64
Date: Wed, 10 Nov 2004 07:52:09 -0800
User-Agent: KMail/1.7.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <200411101154.05304.rjw@sisk.pl> <200411100736.08055.david-b@pacbell.net> <200411110042.25440.rjw@sisk.pl>
In-Reply-To: <200411110042.25440.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411100752.09531.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 November 2004 15:42, Rafael J. Wysocki wrote:
> On Wednesday 10 of November 2004 16:36, David Brownell wrote:
> > On Wednesday 10 November 2004 06:57, Rafael J. Wysocki wrote:
> > > On Wednesday 10 of November 2004 14:58, David Brownell wrote:
> > 
> > > > I recently posted several USB PM fixes that make things work better
> > > > in my testing, and it sounds like they'd probably help here too.
> > > 
> > > Are they available as stand-alone patches?  I'd like to test ...
> > 
> > Yes, check the linux-usb-devel archives from Sunday evening.
> 
> Thanks a lot.  These patches evidently fix the problem described in this 
> thread (verified on two different AMD64-based configurations).

Good -- many thanks for the confirmation!  So I've seen
it work on EHCI+OHCI controllers from NVidia (NF2, NF3),
ALI, and SiS ... I'll hope Greg merges those into his
BK tree for 2.6.10 soonish.

- Dave

