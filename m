Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUCVL74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 06:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbUCVL74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 06:59:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:17897 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261900AbUCVL7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 06:59:54 -0500
Date: Mon, 22 Mar 2004 17:34:47 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Abhishek Rai <abba@fsl.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: put_super for proc
Message-ID: <20040322120446.GH5898@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <Pine.LNX.4.44.0403212258530.20045-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0403212308440.8761-100000@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403212308440.8761-100000@filer.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 04:22:10AM +0000, Abhishek Rai wrote:
> Hi,
> I am trying to add a put_super for proc as part of some project. Although 
> I've done this right, when I unmount proc, it just doesn't call 
> proc's put_super. Any clues ?
> 

check s_active for super_block. Probably it never drops to zero for /proc

Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
