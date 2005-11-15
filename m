Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVKOBRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVKOBRh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 20:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVKOBRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 20:17:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751304AbVKOBRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 20:17:36 -0500
Date: Mon, 14 Nov 2005 17:17:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: mike kravetz <kravetz@us.ibm.com>
Cc: apw@shadowen.org, haveblue@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] register_ and unregister_memory_notifier should be
 global
Message-Id: <20051114171748.7b2f64da.akpm@osdl.org>
In-Reply-To: <20051115003031.GA19640@w-mikek2.ibm.com>
References: <exportbomb.1131997056@pinky>
	<20051114193738.GA15494@shadowen.org>
	<20051114152316.4060d30c.akpm@osdl.org>
	<20051115003031.GA19640@w-mikek2.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike kravetz <kravetz@us.ibm.com> wrote:
>
> On Mon, Nov 14, 2005 at 03:23:16PM -0800, Andrew Morton wrote:
> > Andy Whitcroft <apw@shadowen.org> wrote:
> > >
> > > Both register_memory_notifer and unregister_memory_notifier are global
> > > and declared so in linux.h.  Update the HOTPLUG specific definitions
> > > to match.  This fixes a compile warning when HOTPLUG is enabled.
> > 
> > There is no linux.h and I can find no .h file which declares
> > register_memory_notifier().  Please clarify?
> 
> I'm pretty sure Andy meant to say <linux/memory.h> not linux.h.
> 

hm, OK, and I just lost my grep license.  Thanks.
