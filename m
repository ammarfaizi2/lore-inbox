Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbUEFPKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUEFPKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUEFPKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:10:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:26076 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262441AbUEFPKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:10:42 -0400
Date: Thu, 6 May 2004 08:10:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: pazke@donpac.ru, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>
Subject: Re: [RFC] DMI cleanup patches
Message-Id: <20040506081012.6cb4ab2f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405060738430.3271@ppc970.osdl.org>
References: <20040506102904.GA3295@pazke>
	<Pine.LNX.4.58.0405060738430.3271@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Thu, 6 May 2004, Andrey Panin wrote:
> > 
> > currently arch/i386/kernel/dmi_scan.c file looks like complete
> > mess. Interfacing with other kernel subsystem made using
> > ad-hoc ways, mostly with ugly global variables, additionaly
> > coding style is ... not good. So these patches appear:
> 
> The patches look good by me, but I'd rather leave them to after 2.6.6, 
> since they seem to be cleanups rather than serious bug-fixes.
> 

There is a significant amount of work pending in the DRM development tree
at http://drm.bkbits.net/drm-2.6 (which is included in -mm).  Andrey's
zeroeth patch alone tosses three rejects against it.

David, now would be a good time to start getting that code ready for a
merge.

Andrey, you should rebase your patches on top of the DRM tree, or -mm, and
copy David on the emails.

Thanks.
