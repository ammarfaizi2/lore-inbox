Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUAAR7k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 12:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbUAAR7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 12:59:40 -0500
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:10937 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264500AbUAAR7j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 12:59:39 -0500
Subject: Re: [Dri-devel] 2.6 kernel change in nopage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: William Lee Irwin III <wli@holomorphy.com>, Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1072965029.1603.261.camel@thor.asgaard.local>
References: <20031231182148.26486.qmail@web14918.mail.yahoo.com>
	 <1072958618.1603.236.camel@thor.asgaard.local>
	 <20040101133301.GB3242@holomorphy.com>
	 <1072965029.1603.261.camel@thor.asgaard.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1072979706.28413.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 01 Jan 2004 17:55:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-01-01 at 13:50, Michel Dänzer wrote:
> > Okay, you did something weird with nopage args, but I thought I did
> > the equivalent of this in the original patch?
> 
> This is about the canonical DRM code in the DRI tree.

99.9% of people run the DRM code in the kernel tree, so definitions of 
canonical might vary. I don't personally see a problem with the ifdefs.
The DRI devel tree has to work with anything, the kernel gets the luxury
of being able to strip out the defines that aren't needed for that
specific release.

Alan

