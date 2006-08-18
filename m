Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWHRIbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWHRIbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 04:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWHRIbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 04:31:24 -0400
Received: from colin.muc.de ([193.149.48.1]:45070 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751213AbWHRIbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 04:31:23 -0400
Date: 18 Aug 2006 10:31:21 +0200
Date: Fri, 18 Aug 2006 10:31:21 +0200
From: Andi Kleen <ak@muc.de>
To: "S. P. Prasanna" <prasanna@in.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jan Beulich <jbeulich@novell.com>, jeremy@goop.org, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: Re: [PATCH] Kprobes - x86_64 add KPROBE_END macro for .popsection
Message-ID: <20060818083121.GB5862@muc.de>
References: <20060817171405.GA7973@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817171405.GA7973@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 10:44:05PM +0530, S. P. Prasanna wrote:
> This patch replace .popsection with the KPROBE_END() macro, as
> suggested by Jan Beulich similar to i386 architecture. This will
> be helpful for the conversions ike the recent .section -> .pushsection
> and .previous -> .popsection to be confined to the header defining
> these macros, without need to touch any assembly files.

Already got the change, thank you.

-Andi
