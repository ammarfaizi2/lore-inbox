Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbWF0ITj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWF0ITj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbWF0ITj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:19:39 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:48801 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161042AbWF0ITh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:19:37 -0400
Date: Tue, 27 Jun 2006 04:14:13 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH]microcode update driver rewrite - takes 2
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       Rajesh Shah <rajesh.shah@intel.com>,
       Tigran Aivazian <tigran@veritas.com>
Message-ID: <200606270418_MC3-1-C38C-B2BF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1151376693.21189.52.camel@sli10-desk.sh.intel.com>

On Tue, 27 Jun 2006 10:51:33 +0800, Shaohua Li wrote:

> This is the rewrite of microcode update driver. Changes:

> +             printk(KERN_ERR "microcode: error! Bad data in microcode "
> +                             "data file\n");

I counted five of these "generic" error messages.  I know the original
driver had this problem too because I hit it and couldn't tell where
the message came from.

Could you change these messages so they're unique and they describe the
actual problem better?  E.g. "data too large for user buffer" etc.?

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
