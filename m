Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUA3LU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 06:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbUA3LU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 06:20:27 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:40065 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262153AbUA3LUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 06:20:23 -0500
Date: Fri, 30 Jan 2004 12:20:39 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.2-rc2-mm1
Message-ID: <20040130112039.GA1731@ucw.cz>
References: <20040127233402.6f5d3497.akpm@osdl.org> <20040130104829.GA2505@babylon.d2dc.net> <20040130110205.GA1583@ucw.cz> <20040130111805.GC2505@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130111805.GC2505@babylon.d2dc.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 06:18:05AM -0500, Zephaniah E. Hull wrote:
> On Fri, Jan 30, 2004 at 12:02:05PM +0100, Vojtech Pavlik wrote:
> > On Fri, Jan 30, 2004 at 05:48:29AM -0500, Zephaniah E. Hull wrote:
> > > On Tue, Jan 27, 2004 at 11:34:02PM -0800, Andrew Morton wrote:
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm1/
> > > > 
> > > > - From now on, -mm kernels will contain the latest contents of:
> > > > 
> > > > 	Vojtech's tree:		input.patch
> > > 
> > > This one seems to have a rather problematic patch, which I can't find
> > > any explanation for.
> > 
> > There is another revision of the same mouse from A4Tech (owned by
> > Jaroslav Kysela), that reports itself as Cypress and has the buttons a
> > bit differently.
> > 
> > If it indeed collides with your mouse, then we need somehow to specify
> > which button carries the wheel information in the quirk list.
> 
> Ugh, that is not fun, it does indeed conflict.
> How about HID_QUIRK_2WHEEL_MOUSE_HACK_EXTRA and
> HID_QUIRK_2WHEEL_MOUSE_HACK_BACK as quirk names?

Sounds OK.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
