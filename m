Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbUC2VYE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUC2VYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:24:04 -0500
Received: from ida.rowland.org ([192.131.102.52]:10500 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262953AbUC2VYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:24:01 -0500
Date: Sat, 27 Mar 2004 18:51:36 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Grzegorz Kulewski <kangur@polcom.net>
cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       lkml <linux-kernel@vger.kernel.org>, <wolk-devel@lists.sourceforge.net>,
       <linux-usb-devel@lists.sf.net>, <speedtouch@ml.free.fr>
Subject: Re: [linux-usb-devel] speedtouch and/or USB problem (2.6.4-WOLK2.3)
In-Reply-To: <Pine.LNX.4.58.0403272228360.2662@alpha.polcom.net>
Message-ID: <Pine.LNX.4.44L0.0403271851040.2209-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Mar 2004, Grzegorz Kulewski wrote:

> Hi,
> 
> When running modem_run on 2.6.4-WOLK2.3 it locks in D state on one of USB 
> ioctls. It works at least on 2.6.2-rc2. I have no idea what causes this 
> bug so I sent it to all lists.
> 
> Please help if you can.
> 
> Grzegorz Kulewski

Try applying this patch:

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108016447231291&q=raw

Alan Stern

