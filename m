Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264448AbUEJCEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbUEJCEM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 22:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbUEJCEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 22:04:12 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:51330 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264448AbUEJCEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 22:04:09 -0400
Date: Mon, 10 May 2004 11:03:21 +0900
From: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Subject: Re: [ANNOUNCE] [PATCH] Node Hotplug Support
In-reply-to: <540080000.1083946609@[10.10.2.4]>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       lhns-devel@lists.sourceforge.net
Message-id: <20040510110321.225a2334.tokunaga.keiich@jp.fujitsu.com>
Organization: FUJITSU LIMITED
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
 <540080000.1083946609@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 May 2004 09:16:51 -0700
"Martin J. Bligh" <mbligh@aracnet.com> wrote:

> > ACPI is used to do some hardware manipulation.
> > There is no general purpose interface to get hardware information
> > and manipulate hardware today, but hardware proprietary interfaces.
> > ACPI is one of them, and I decided to use it because:
> > 
> >   - Its spec is open.
> >   - I can use it without any hardware special knowledge:)
> 
> You can't base platform-independant Linux code on ACPI, when not all
> NUMA boxes will support it. The fact that your particular box may
> support it doesn't make it a generally applicable idea ;-)

I'm not trying to base everything on ACPI, this happens in the first
patces though.  I would separate them in the future release.
(Actually I put comments about it in the first patch:)

There will be the dependent and independent codes.  Any platform
can share the independent code, and dependent code needs to
be made by each platform.  I think that PCI hotplug takes the same
way.

Thanks,
Kei
