Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbVHKM5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbVHKM5a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbVHKM5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:57:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9614 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030294AbVHKM53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:57:29 -0400
Date: Thu, 11 Aug 2005 05:57:16 -0700
From: Chris Wright <chrisw@osdl.org>
To: zach@vmware.com
Cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zwame@arm.linux.org.uk
Subject: Re: [PATCH 1/14] i386 / Make write ldt return error code
Message-ID: <20050811125716.GW7762@shell0.pdx.osdl.net>
References: <200508110452.j7B4qpSE019505@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508110452.j7B4qpSE019505@zach-dev.vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* zach@vmware.com (zach@vmware.com) wrote:
> Xen requires error returns from the hypercall to update LDT entries,
> and this generates completely equivalent code on native.

The whole lot looks quite nice.  I've sucked them into a git tree 
with the full set until Andrew's back.  If it's useful we can work
against that tree.

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/virt-2.6

thanks,
-chris
