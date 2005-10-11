Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVJKRiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVJKRiS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 13:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVJKRiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 13:38:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:44516 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932200AbVJKRiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 13:38:17 -0400
Date: Tue, 11 Oct 2005 10:37:46 -0700
From: Paul Jackson <pj@sgi.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: laforge@gnumonks.org, torvalds@osdl.org, chrisw@osdl.org, vsu@altlinux.ru,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       security@linux.kernel.org, vendor-sec@lst.de
Subject: Re: [linux-usb-devel] Re: [BUG/PATCH/RFC] Oops while completing
 async USB via usbdevio
Message-Id: <20051011103746.61598183.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.44L0.0510101559330.10768-100000@netrider.rowland.org>
References: <20051010174429.GH5627@rama>
	<Pine.LNX.4.44L0.0510101559330.10768-100000@netrider.rowland.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan asked:
> But why do people go to the
> effort of confusing readers by using "^" instead of "!="? 

My guess - eor (^) was quicker than not-equal (!=) on a PDP-11.

That code fragment for checking uid's has been around a -long-
time, if my memory serves me.

It's gotten to be like the infamous "!!" boolean conversion
operator, a bit of vernacular that would be harder to read if
recoded using modern coding style.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
