Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTLNU1y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 15:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTLNU1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 15:27:53 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:27923 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262373AbTLNU1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 15:27:45 -0500
Date: Sun, 14 Dec 2003 21:27:41 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 and IDE "geometry"
Message-ID: <20031214202741.GA11909@win.tue.nl>
References: <20031212131704.A26577@animx.eu.org> <20031212194439.GB11215@win.tue.nl> <20031212163545.A26866@animx.eu.org> <20031213132208.GA11523@win.tue.nl> <20031213171800.A28547@animx.eu.org> <20031214144046.GA11870@win.tue.nl> <20031214112728.A8201@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031214112728.A8201@animx.eu.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 14, 2003 at 11:27:28AM -0500, Wakko Warner wrote:

> > Or does it suffice to take */255/63 always?
> 
> I would say most cases use the 255/63

Good. So you can try constant geometry setting with *fdisk.

> with drives >4gb.  Is there anyway to query the bios to ask it?

Yes, and that is what the kernel used to do.
In general, however, the answer is unreliable. 

