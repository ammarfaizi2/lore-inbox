Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932770AbWFXAvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbWFXAvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 20:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933164AbWFXAvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 20:51:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932770AbWFXAvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 20:51:14 -0400
Date: Fri, 23 Jun 2006 17:50:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: nkiesel@tbdnetworks.com (Norbert Kiesel)
Cc: bfennema@falcon.csc.calpoly.edu, linux-kernel@vger.kernel.org
Subject: Re: OOPS in UDF
Message-Id: <20060623175033.664ddcce.akpm@osdl.org>
In-Reply-To: <20060615155828.GA14257@defiant.tbdnetworks.com>
References: <20060615155828.GA14257@defiant.tbdnetworks.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2006 08:58:28 -0700
nkiesel@tbdnetworks.com (Norbert Kiesel) wrote:

> I just got an OOPS while copying between two loopback-mounted UDF filesystems.
> One or both of the UDF file systems are corrupted (some files not readable by
> root), but kernel should not OOPS anyway.
> 
> I get the corrupted file systems reliably by rsync'ing big directories onto the
> UDF filesystem (while trying to prepare a backup DVD).  I saw the OOPS only once
> so far.  The system continued to work after the OOPS.

Are you able to get a copy of one of these filesystem images up onto a
server somewhere so others can reproduce the crash?

