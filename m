Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVAGBLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVAGBLh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVAGBL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:11:28 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:62099 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261200AbVAGBGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:06:34 -0500
Subject: Re: [bootfix] pass used_node_mask by reference in 2.6.10-mm1
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200501031244.06651.jbarnes@engr.sgi.com>
References: <20050103191319.GO29332@holomorphy.com>
	 <20050103195016.GP29332@holomorphy.com>
	 <200501031244.06651.jbarnes@engr.sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1105059997.19633.2.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 06 Jan 2005 17:06:37 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 12:44, Jesse Barnes wrote:
> On Monday, January 3, 2005 11:50 am, William Lee Irwin III wrote:
> > On Mon, Jan 03, 2005 at 11:13:19AM -0800, William Lee Irwin III wrote:
> > > Without passing this parameter by reference, the changes to
> > > used_node_mask are meaningless and do not affect the caller's copy.
> > > This leads to boot-time failure. This proposed fix passes it by
> > > reference.
> >
> > This proposed fix is an actual fix according to my own testing.
> >
> > Without the patch applied, my quad em64t does not boot, and livelocks
> > prior to console_init().
> >
> > With the patch applied, my quad em64 boots and runs normally.
> 
> Makes my Altix boot as well.  Thanks for the fix.
> 
> Jesse

Yep.  Thanks for that, Bill!  That was pretty stupid of me, although I
did manage to get a couple machines over here to boot with the broken
code...?

-Matt

