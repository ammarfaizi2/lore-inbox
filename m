Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269160AbTGJKCi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266313AbTGJKCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:02:37 -0400
Received: from sol.cc.u-szeged.hu ([160.114.8.24]:20464 "EHLO
	sol.cc.u-szeged.hu") by vger.kernel.org with ESMTP id S269160AbTGJKCf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:02:35 -0400
Date: Thu, 10 Jul 2003 12:17:11 +0200 (CEST)
From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
To: Max Valdez <maxvalde@fis.unam.mx>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       kernel <linux-kernel@vger.kernel.org>
Subject: Re: undefined reference to `xapic_support`
In-Reply-To: <1057748698.6292.5.camel@garaged.homeip.net>
Message-ID: <Pine.LNX.4.44.0307101216170.30460-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jul 2003, Max Valdez wrote:

> No, i dont need that, i tried it to see if it corrected the problem, but
> didnt
>
> :-)
> Max
> On Wed, 2003-07-09 at 00:52, Martin J. Bligh wrote:
> > >> CONFIG_X86_CLUSTERED_APIC=y
> >
> > Why? Do you really need this?

IO_APIC is broken in 2.4.22-pre3-ac1. So you cannot compile SMP kernels,
or UP kernels with IO_APIC support.

  Geller Sandor <wildy@petra.hos.u-szeged.hu>

