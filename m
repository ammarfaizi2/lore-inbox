Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266283AbUFPN4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266283AbUFPN4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 09:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266285AbUFPN4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 09:56:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:57311 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266283AbUFPN4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 09:56:40 -0400
Subject: Re: Linux 2.6.7 (stty rows 50 columns 140 reports : No such device
	or address)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Zilvinas Valinskas <zilvinas@gemtek.lt>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40D0432A.1080006@pobox.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
	 <20040616095805.GC14936@gemtek.lt>  <40D0432A.1080006@pobox.com>
Content-Type: text/plain
Message-Id: <1087394174.8697.229.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Jun 2004 08:56:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-16 at 07:55, Jeff Garzik wrote:
> Zilvinas Valinskas wrote:
> > On Compaq N800 EVO notebook with a radeonfb enabled - stty failes to
> > adjust terminal size. strace log attached. Under 2.6.5/2.6.6 it used to
> > work. 
> > 

The whole crap of tweaking the video modes when terminal size is
changed with stty is not working properly imho. I don't like it, I
don't like the way it's implemented and the drivers are not ready
for it anyway since they lack a correct mode matching mecanism.

But that's one of James pet features so ...

Ben.


