Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVDZOw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVDZOw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVDZOw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:52:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:24821 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261400AbVDZOwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:52:21 -0400
Date: Tue, 26 Apr 2005 20:22:10 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Juergen Quade <quade@hsnr.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: system-freeze: kprobe and do_gettimeofday
Message-ID: <20050426145210.GC32766@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20050423101251.GA327@hsnr.de> <20050425155649.GA30272@in.ibm.com> <20050425160859.GA23019@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425160859.GA23019@hsnr.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Apr 25, 2005 at 06:08:59PM +0200, Juergen Quade wrote:
> On Mon, Apr 25, 2005 at 09:26:49PM +0530, Prasanna S Panchamukhi wrote:
> > On Sat, Apr 23, 2005 at 12:12:51PM +0200, Juergen Quade wrote:
> > > Playing around with kprobe I noticed, that "kprobing"
> > > the function "do_gettimeofday" completly freezes the
> > > system (2.6.12-rc3). Other functions like "do_fork" or
> > 
> > Kprobe on "do_gettimeofday" seems to work fine on 4-way SMP i386 box.
> > What is configuration of your machine?
> 
> Thank you for your answer!
> Find my kernel-config attached.
> The processor of the system is an Pentium M
> (1400MHz, 512MByte Memory - nothing specific).
> 

I tested with your configuration file and it still
works fine. Can you get some more info about current tasks 
using Alt+SysRq+t and  Alt+SysRq+d keys.

Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
