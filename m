Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVFKIxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVFKIxx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 04:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVFKIxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 04:53:53 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:14537 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S261647AbVFKI0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 04:26:44 -0400
Date: Sat, 11 Jun 2005 10:26:42 +0200
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Lord <lord@xfs.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
Message-ID: <20050611082642.GB17639@ojjektum.uhulinux.hu>
References: <42A99D9D.7080900@xfs.org> <20050610112515.691dcb6e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610112515.691dcb6e.akpm@osdl.org>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 11:25:15AM -0700, Andrew Morton wrote:
> I wonder if rather than the intermittency being time-based, it is
> load-address-based?  For example, suppose there's a bug in the symbol
> lookup code?

Just a data point: I met the same problem with 2.6.12-rc5, using
gcc 3.3.4.
I think it's time-based issue, because I was playing around with the 
initscripts, and the bug shows up when there are lots of modprobes in a 
short time.



-- 
pozsy
