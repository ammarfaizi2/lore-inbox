Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbUBZX3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUBZX2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:28:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:8665 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261300AbUBZX1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:27:09 -0500
Date: Thu, 26 Feb 2004 15:27:07 -0800
From: Chris Wright <chrisw@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Jochen Roemling <jochen@roemling.net>, linux-kernel@vger.kernel.org
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
Message-ID: <20040226152707.L22989@build.pdx.osdl.net>
References: <403E74D3.4000305@roemling.net> <20040226225214.GP693@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040226225214.GP693@holomorphy.com>; from wli@holomorphy.com on Thu, Feb 26, 2004 at 02:52:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III (wli@holomorphy.com) wrote:
> On Thu, Feb 26, 2004 at 11:36:03PM +0100, Jochen Roemling wrote:
> > How can I grant the permission to use HUGETLB to ordinary users?
> 
> (a) use the fs which uses fs permissions to grant users permission to
> 	fiddle with hugetlb
> (b) man 2 capset

In case that part wasn't clear, it would be CAP_IPC_LOCK capability.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
