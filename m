Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWJEUvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWJEUvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWJEUvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:51:08 -0400
Received: from mx1.suse.de ([195.135.220.2]:32921 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932147AbWJEUvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:51:05 -0400
From: Andi Kleen <ak@suse.de>
To: Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Date: Thu, 5 Oct 2006 22:50:55 +0200
User-Agent: KMail/1.9.3
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       kmannth@us.ibm.com, Andy Whitcroft <apw@shadowen.org>
References: <20060928014623.ccc9b885.akpm@osdl.org> <200610052105.00359.ak@suse.de> <1160080954.29690.44.camel@flooterbu>
In-Reply-To: <1160080954.29690.44.camel@flooterbu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052250.55146.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 22:42, Steve Fox wrote:
> On Thu, 2006-10-05 at 21:05 +0200, Andi Kleen wrote:
> 
> > Can you please try it again with this patch to narrow it down further?
> 
> Unfortunately this is as far as it got before it hung.

Boot with earlyprintk=serial,ttyS0,57600
(or change the panic in the checkfunction back to a printk) 

-Andi

