Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUCKNkZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUCKNkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:40:24 -0500
Received: from uni02du.unity.ncsu.edu ([152.1.13.102]:27520 "EHLO
	uni02du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S261273AbUCKNkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:40:19 -0500
From: jlnance@unity.ncsu.edu
Date: Thu, 11 Mar 2004 08:40:17 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040311134017.GA2813@ncsu.edu>
References: <20040310233140.3ce99610.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310233140.3ce99610.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 11:31:40PM -0800, Andrew Morton wrote:
>   This affects I/O scheduling potentially quite significantly.  It is no
>   longer the case that the kernel will submit pages for I/O in the order in
>   which the application dirtied them.  We instead submit them in file-offset
>   order all the time.

Hi Andrew,
    I have a feeling this change might significantly improve the external
sorting benchmark I emailed you ( http://lkml.org/lkml/2003/12/20/46 ).
I will try running it when I get a chance and let you know.  It gives me
a good excuse to get 2.6 kernels working on my systems :-)

Thanks,

Jim

-- 
www.jeweltran.com
