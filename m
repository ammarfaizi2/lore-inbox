Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUCTETN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 23:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUCTETM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 23:19:12 -0500
Received: from fmr05.intel.com ([134.134.136.6]:49087 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263226AbUCTETL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 23:19:11 -0500
Subject: Re: 2.6.4-mm2
From: Len Brown <len.brown@intel.com>
To: Mark Wong <markw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, axboe@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F5E26@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F5E26@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1079756340.7277.631.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 19 Mar 2004 23:19:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-19 at 21:53, Mark Wong wrote:

> > Thanks, so it's the CPU scheduler changes.  Is that machine
> hyperthreaded? 
> > And do you have CONFIG_X86_HT enabled?
> 
> Yes and CONFIG_X86_HT is enabled but I have hyperthreading disabled
> with
> 'acpi=off noht' (whichever one does it.)  

CONFIG_X86_HT=y does not enable HT.
CONFIG_X86_HT=n does not disable HT.
It only controls if the cpu_sibling_map[] etc. are initialized.

acpi=off does not disable HT
"noht" doesn't exist.

Please see my message yesterday w/ subject "how to disable HT"

cheers,
-Len


