Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTFBMtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTFBMtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:49:20 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:8364 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262284AbTFBMtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:49:19 -0400
Subject: Re: Latest runs by LTC Test
From: Stephanie Glass <sglass@linuxtestproject.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1054313577.1530.117.camel@nighthawk>
References: <1054311252.14899.68.camel@saglasstest.austin.ibm.com> 
	<1054313577.1530.117.camel@nighthawk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Jun 2003 08:04:39 -0500
Message-Id: <1054559080.14931.102.camel@saglasstest.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-30 at 11:52, Dave Hansen wrote:
> On Fri, 2003-05-30 at 09:14, Stephanie Glass wrote:
> > LTC test has updated the 2.5 test runs on both the ltp and osdl site.
> > 
> > The actual pages are for the LTP site at:
> > http://ltp.sourceforge.net/execmatrix.php
> > or OSDL site at:
> > http://www.osdl.org/projects/26lnxstblztn/results/linstab-web/ltc/execut25_324rev1.html
> > 
> > All new runs where done on either 2.5.69 or 2.5.70
> 
> Was there anything significant in the results?  Any new failures?
> 
> -- 
> Dave Hansen
> haveblue@us.ibm.com
> 
Yes, defect 732.  We now seem to have a memory leak because one of our
applications for database testing no longer can run more than one
instance on a client box. Otherwise, it looks good.  2.5.70 is allowing
us to run some stuff which had stopped working.


