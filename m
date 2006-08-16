Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWHPOsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWHPOsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWHPOsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:48:53 -0400
Received: from one.firstfloor.org ([213.235.205.2]:13734 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S1751194AbWHPOsx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:48:53 -0400
Date: Wed, 16 Aug 2006 16:48:48 +0200
From: Andi Kleen <ak@muc.de>
To: prasanna@in.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jan Beulich <jbeulich@novell.com>, jeremy@goop.org, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: Re: Kprobes - i386 add KPROBE_END macro for .popsection
Message-Id: <20060816164848.0e2d6667.ak@muc.de>
In-Reply-To: <20060816134932.GA28965@in.ibm.com>
References: <20060816134932.GA28965@in.ibm.com>
Organization: unorganized
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 19:19:32 +0530
"S. P. Prasanna" <prasanna@in.ibm.com> wrote:

> This patch add a macro KPROBE_END() to add .popsection after each
> KPROBE_ENTRY() usage, as suggested by Jan Beulich. This patch also
> replace .popsection with the KPROBE_END() macro.
> This will be helpful for the conversions like the recent
>  .section -> .pushsection and .previous -> .popsection to be
> confined to the header defining these macros, without need to touch
> any assembly files.

I merged it with the existing patches. Thanks.

-Andi
