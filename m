Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUAIO1V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 09:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbUAIO1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 09:27:21 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:20642 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261885AbUAIO1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 09:27:18 -0500
Date: Fri, 9 Jan 2004 06:28:45 -0800
From: Paul Jackson <pj@sgi.com>
To: joe.korty@ccur.com
Cc: paulus@samba.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040109062845.273de5f9.pj@sgi.com>
In-Reply-To: <20040108225929.GA24089@tsunami.ccur.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe, responding to Paul M:
> > Why do you have to reference them as u32?  Why can't you use unsigned
> > long instead?  That should Just Work.
> 
> I believe he wants the commas to group the digits by at most eight
> irrespective of architecture.  Which seems reasonable.


Yes - that's why I use u32 - each comma separated word in the
ascii representation of a mask represents 32 bits, regardless
of the native word size of the current architecture.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
