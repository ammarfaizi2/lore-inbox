Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVCXOWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVCXOWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 09:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVCXOWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 09:22:21 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:39907 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262474AbVCXOWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 09:22:17 -0500
Date: Thu, 24 Mar 2005 19:50:33 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Mike kravetz <kravetz@us.ibm.com>, linuxppc64-dev@ozlabs.org,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: Add mem=X option, updated NUMA support
Message-ID: <20050324142033.GA11276@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <200503232311.11113.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503232311.11113.michael@ellerman.id.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 11:11:10PM +1100, Michael Ellerman wrote:
> Hi Mike,
> 
> Here's an updated version of my mem=X patch with new NUMA code.
> Sorry it took so long I've been a bit crook.
> 
> Can you test this on your 720 or whatever it was? And if anyone else
> has an interesting NUMA machine they can test it on I'd love to hear
> about it!
> 
> This also includes a fix for the bug Maneesh found last week with
> GCC 3.3 generating a switch table in prom_init.c, which doesn't
> work.
> 

I tried the patch and it works fine in my setup also.

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
