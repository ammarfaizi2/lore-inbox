Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbUKDWzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUKDWzC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbUKDWwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:52:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:15333 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262460AbUKDWsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:48:41 -0500
Date: Thu, 4 Nov 2004 14:48:39 -0800
From: Chris Wright <chrisw@osdl.org>
To: Serge Hallyn <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] [6/6] LSM Stacking: temporary setprocattr hack
Message-ID: <20041104144839.C2357@build.pdx.osdl.net>
References: <1099609471.2096.10.camel@serge.austin.ibm.com> <1099609971.2096.26.camel@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1099609971.2096.26.camel@serge.austin.ibm.com>; from serue@us.ibm.com on Thu, Nov 04, 2004 at 05:12:51PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge Hallyn (serue@us.ibm.com) wrote:
> Stacker assumes that data written to /proc/<pid>/attr/* is of the
> form:
> 
> module_name: data

This breaks current tools where fields are space-delimited.  procps does
filtering that way, and I believe libselinux does as well.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
