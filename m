Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVFTVbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVFTVbS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVFTV2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:28:44 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:13753 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261541AbVFTVZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:25:00 -0400
Date: Tue, 21 Jun 2005 02:52:17 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: jan malstrom <xanon@snacksy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-mm1 (kernel BUG at fs/open.c:935!)
Message-ID: <20050620212217.GD4562@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <42B6BEC2.405@snacksy.com> <20050620202145.GC4622@in.ibm.com> <200506202318.37930.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506202318.37930.rjw@sisk.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 11:18:37PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, 20 of June 2005 22:21, Dipankar Sarma wrote:
> > On Mon, Jun 20, 2005 at 03:04:02PM +0200, jan malstrom wrote:
> > > right at booting:
> > > 
> > > 
> > > Jun 20 14:38:07 hades kernel: kernel BUG at fs/open.c:935!
> > > Jun 20 14:38:07 hades kernel: invalid operand: 0000 [#1]
> > > Jun 20 14:38:07 hades kernel: PREEMPT
> > > Jun 20 14:38:07 hades kernel: Modules linked in: ipw2100 i2c_i801
> > > Jun 20 14:38:07 hades kernel: CPU:    0
> > > Jun 20 14:38:07 hades kernel: EIP:    0060:[fd_install+309/400]    Not 
> > > tainted VLI
> > 
> > Can you try the following patch and let me know if it fixes any
> > of your problems ?
> 
> No, it doesn't.

Does it always happen with kded and always on reiser4 or does it happen
with other FS ? I tested with Jan's .config and couldn't reproduce it
in my P4 box. What exactly are you running in your machine ?

Thanks
Dipankar
