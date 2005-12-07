Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVLGOHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVLGOHw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVLGOHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:07:52 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:29046 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1750707AbVLGOHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:07:51 -0500
Date: Wed, 07 Dec 2005 09:07:18 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
In-reply-to: <Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
To: "J.O. Aho" <trizt@iname.com>
Cc: "David S. Miller" <davem@davemloft.net>,
       linux-kernel maillist <linux-kernel@vger.kernel.org>,
       sparclinux@vger.kernel.org
Message-id: <1133964439.23898.1.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.2
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.64.0512060257160.27930@lai.local.lan>
 <20051205.181732.34234732.davem@davemloft.net>
 <Pine.LNX.4.64.0512061658190.14952@lai.local.lan>
 <20051206.152316.82233251.davem@davemloft.net>
 <Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 12:05 +0100, J.O. Aho wrote:
> Xorg jumps to VT7, you see a console cursor, "_", at the top left corner 
> and thats it. It's impossible to change back to VT1 (or any other), the 
> only thing that works is to press [stop]-[a] so that you get back to the
> OBP from where I can reset the machine (resetting by the reset button 
> don't work). It's still possible to ssh to the machine, more and dmesg is 
> possible, but running ps causes the machine to completly lock up, change 
> init mode don't give any affects att all and trying to turn off or kill X 
> results in the same as ps.

Does the dmesg contain any sort of oops?

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

