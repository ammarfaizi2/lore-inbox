Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbULHSke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbULHSke (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbULHSke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:40:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:48082 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261303AbULHSk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:40:28 -0500
Subject: RE: Figuring out physical memory regions from a kernel module
From: Dave Hansen <haveblue@us.ibm.com>
To: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <C863B68032DED14E8EBA9F71EB8FE4C20596020D@azsmsx406>
References: <C863B68032DED14E8EBA9F71EB8FE4C20596020D@azsmsx406>
Content-Type: text/plain
Message-Id: <1102531227.883.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Dec 2004 10:40:27 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 10:28, Hanson, Jonathan M wrote:
>  The module is dumping the contents of physical memory
> and saving the architecture state of the system to a file when triggered
> (ioctl call). What I have works but I need to extend it to systems other
> than my own where I have hard-coded the system RAM regions into the
> code. I need the physical addresses of memory because the tool I feed
> this output into requires this. Here is an example of what the memory
> file looks like:

Sounds like crash dumping.  I think they've already run into and
addressed the same general problems.  

See crashdump-*.patch in here:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/broken-out/

-- Dave

