Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263509AbUCYTMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 14:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbUCYTMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 14:12:55 -0500
Received: from colino.net ([62.212.100.143]:40688 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S263509AbUCYTMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 14:12:53 -0500
Date: Thu, 25 Mar 2004 20:11:57 +0100
From: Colin Leroy <colin@colino.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Re: [linux-usb-devel] Re: [OOPS] reproducible oops with
 2.6.5-rc2-bk3
Message-Id: <20040325201157.6551b5e9@jack.colino.net>
In-Reply-To: <Pine.LNX.4.44L0.0403251341550.1083-100000@ida.rowland.org>
References: <20040325184620.3b6b070c@jack.colino.net>
	<Pine.LNX.4.44L0.0403251341550.1083-100000@ida.rowland.org>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 Mar 2004 at 13h03, Alan Stern wrote:

Hi, 

> In this case, your patch could be improved by calling device_initialize()  
> during the first loop and device_add() during the second.  However, that
> region of code is kind of in flux right at the moment.  When things settle
> down, I promise to remember your change and make sure it gets in.

ok :) 
Will this get stabilized before 2.6.5 or after ? (just so I remember to patch it myself if needed...)

Thanks,
-- 
Colin
