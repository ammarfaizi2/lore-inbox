Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWJEENi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWJEENi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 00:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWJEENh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 00:13:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48278 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbWJEENg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 00:13:36 -0400
Date: Wed, 4 Oct 2006 21:12:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] Cast removal
Message-Id: <20061004211259.8274db49.akpm@osdl.org>
In-Reply-To: <200610042356.03348.len.brown@intel.com>
References: <Pine.LNX.4.61.0610010026050.32229@yvahk01.tjqt.qr>
	<200610042356.03348.len.brown@intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 23:56:02 -0400
Len Brown <len.brown@intel.com> wrote:

> I'm okay applying this patch it touches the linux-specific
> drivers/acpi/* files only, no ACPICA files.

Why?

Would it help if it was split into two?

How do mortals distinguish ACPICA files from Linux files?

> But I don't know if Linus will want changes like this post -rc1.
> It might be a pain to have in the tree all the way to 2.6.20 opens b/c
> it is sure to cause merge conflicts

Should be OK - the acpi tree is very slow-changing at present.  Or did you
have big changes planned?

Or I can maintain it externally along with the 10-20 other acpi patches I
seem to be regularly stuck with (hint ;)

> -- and at the end of the day
> the benefit of this patch is what?  A few less characters in the source... 
>

yes, cleanups are a pain, and we do a lot of them.  And we merge just about
all of them.  But I think it's best in the long run; and we are in this for
the long run.  
