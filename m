Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbUCCBBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 20:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbUCCBBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 20:01:33 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:53349 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262306AbUCCBBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 20:01:31 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Ben Collins <bcollins@debian.org>
Subject: Re: 2.6.4-rc1: OOPS when daisy-chaining ieee1394 devices
Date: Tue, 2 Mar 2004 20:01:24 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200403012229.35742.dtor_core@ameritech.net> <20040302041849.GQ1078@phunnypharm.org>
In-Reply-To: <20040302041849.GQ1078@phunnypharm.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403022001.24938.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 March 2004 11:18 pm, Ben Collins wrote:
> On Mon, Mar 01, 2004 at 10:29:34PM -0500, Dmitry Torokhov wrote:
> > Hi,
> > 
> > Got the following oops when trying to power up DVD burner daisy chained to
> > a WD hard drive. Reproducible with latest -bk as well as with ieee1394 patch
> > from -mm tree. This is a regression as it was somewhat worked with earlier
> > 2.6 kernels (well, earlier kernels could only log in into the last powered
> > device, reconnecting to devices sitting earlier in chain was always failing),
> > but there was no oopses.
> 
> Let me know if this patch works for you.
> 

It works very nicely, no more oopses and I can even access both daisy-chained
devices simultaneously.

Great job, thanks!

-- 
Dmitry
