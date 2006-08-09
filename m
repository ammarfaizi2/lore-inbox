Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWHIUCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWHIUCU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWHIUCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:02:20 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:55011 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751340AbWHIUCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:02:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend to disk on i386
Date: Wed, 9 Aug 2006 22:01:42 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200608091426.31762.rjw@sisk.pl> <20060809123052.GB3808@elf.ucw.cz>
In-Reply-To: <20060809123052.GB3808@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608092201.42885.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 14:30, Pavel Machek wrote:
> Hi!
> > 
> > It looks like the CMOS clock gets corrupted during the suspend to disk
> > on i386.  I've observed this on 2 different boxes.  Moreover, one of them is
> > AMD64-based and the x86_64 kernel doesn't have this problem on it.
> > 
> > Also, I've done some tests that indicate the corruption doesn't occur before
> > saving the suspend image.  It rather happens when the box is powered off
> > or rebooted (tested both cases).
> > 
> > Unfortunately, I have no more time to debug it further right now.
> 
> Do you have Linus' "please corrupt my cmos for debuggin" hack enabled?

Well, I know nothing about that. ;-)

Rafael
