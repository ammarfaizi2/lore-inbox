Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVC2XDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVC2XDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVC2XDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:03:49 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:39319 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261614AbVC2XDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:03:35 -0500
Subject: Re: RFC: 2.6.release.patchlevel:  Patch against 2.6.release[.0] ?
From: Dave Hansen <haveblue@us.ibm.com>
To: "L. A. Walsh" <lkml@tlinx.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4249DC03.4000806@tlinx.org>
References: <4249DC03.4000806@tlinx.org>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 15:03:21 -0800
Message-Id: <1112137401.27732.58.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 14:51 -0800, L. A. Walsh wrote:
> Given the frequency with which stabilization patches may be released, it
> may not be practical to expect users to catch each release announcement
> and download each patch.

I highly suggest using ketchup for your kernel patching needs:
http://www.selenic.com/ketchup/

Here, I have a plain 2.6.11 kernel that I upgrade to 2.6.11.4.  I then
want it to go right to 2.6.11.6.  

dave@kernel:~/temp/linux-2.6.11$ ketchup 2.6.11.4
2.6.11 -> 2.6.11.4
Applying patch-2.6.11.4.bz2
dave@kernel:~/temp/linux-2.6.11$ ketchup 2.6.11.6
2.6.11.4 -> 2.6.11.6
Applying patch-2.6.11.4.bz2 -R
Applying patch-2.6.11.6.bz2
dave@kernel:~/temp/linux-2.6.11$

BTW, it also keeps a cache of local patches, and downloads if needed.
So, you'll see the downloads the first time that you use it for any
given patch.

Does that help?

-- Dave

